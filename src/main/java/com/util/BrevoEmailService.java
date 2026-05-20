package com.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class BrevoEmailService {

    private static final String BREVO_API_URL = "https://api.brevo.com/v3/smtp/email";
    
    // Local fallback for simple setup.
    // If app.properties / environment variables are not working on a machine,
    // paste the values here directly and restart the server.
    private static final String LOCAL_BREVO_API_KEY = "";
    private static final String LOCAL_BREVO_SENDER_EMAIL = "";
    private static final String LOCAL_BREVO_SENDER_NAME = "Stationery Delivery";

    public void sendOtpEmail(String recipientEmail, String recipientName, String otpCode, String purpose)
            throws IOException {

        String apiKey = firstConfigured(
                AppConfig.get("brevo.api.key", "BREVO_API_KEY"),
                LOCAL_BREVO_API_KEY);
        String senderEmail = firstConfigured(
                AppConfig.get("brevo.sender.email", "BREVO_SENDER_EMAIL"),
                LOCAL_BREVO_SENDER_EMAIL);
        String senderName = AppConfig.get("brevo.sender.name", "BREVO_SENDER_NAME");

        if (apiKey == null) {
            throw new IllegalStateException("Brevo API key is not configured.");
        }

        if (senderEmail == null) {
            throw new IllegalStateException("Brevo sender email is not configured.");
        }

        if (senderName == null) {
            senderName = firstConfigured(LOCAL_BREVO_SENDER_NAME, "Stationery Delivery");
        }

        String subject = "register".equalsIgnoreCase(purpose)
                ? "Verify your Stationery Delivery registration"
                : "Verify your Stationery Delivery login";

        int expiryMinutes = OtpUtil.getExpiryMinutes();
        String friendlyName = recipientName == null || recipientName.trim().isEmpty() ? "Customer" : recipientName.trim();

        String textContent = "Hello " + friendlyName + ",\n\n"
                + "Your OTP for " + purpose + " is: " + otpCode + "\n"
                + "This code will expire in " + expiryMinutes + " minutes.\n\n"
                + "If you did not request this, please ignore this email.\n";

        String htmlContent = "<html><body style=\"font-family:Arial,sans-serif;color:#222;\">"
                + "<h2 style=\"margin-bottom:8px;\">Stationery Delivery OTP</h2>"
                + "<p>Hello " + escapeHtml(friendlyName) + ",</p>"
                + "<p>Use the OTP below to complete your " + escapeHtml(purpose) + ".</p>"
                + "<div style=\"font-size:28px;font-weight:bold;letter-spacing:6px;"
                + "background:#f4f4f4;padding:16px 20px;display:inline-block;border-radius:8px;\">"
                + escapeHtml(otpCode) + "</div>"
                + "<p style=\"margin-top:16px;\">This code will expire in " + expiryMinutes + " minutes.</p>"
                + "<p style=\"color:#666;\">If you did not request this, you can ignore this email.</p>"
                + "</body></html>";

        String payload = "{"
                + "\"sender\":{\"name\":\"" + escapeJson(senderName) + "\",\"email\":\"" + escapeJson(senderEmail) + "\"},"
                + "\"to\":[{\"email\":\"" + escapeJson(recipientEmail) + "\",\"name\":\"" + escapeJson(friendlyName) + "\"}],"
                + "\"subject\":\"" + escapeJson(subject) + "\","
                + "\"textContent\":\"" + escapeJson(textContent) + "\","
                + "\"htmlContent\":\"" + escapeJson(htmlContent) + "\""
                + "}";

        HttpURLConnection connection = null;

        try {
            connection = (HttpURLConnection) new URL(BREVO_API_URL).openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("accept", "application/json");
            connection.setRequestProperty("content-type", "application/json");
            connection.setRequestProperty("api-key", apiKey);

            byte[] requestBody = payload.getBytes(StandardCharsets.UTF_8);
            connection.setFixedLengthStreamingMode(requestBody.length);

            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(requestBody);
            outputStream.flush();
            outputStream.close();

            int responseCode = connection.getResponseCode();

            if (responseCode < 200 || responseCode >= 300) {
                String errorBody = readResponse(connection.getErrorStream());
                throw new IOException("Brevo email send failed. HTTP " + responseCode + ". " + errorBody);
            }

        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    private String readResponse(InputStream inputStream) throws IOException {
        if (inputStream == null) {
            return "";
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8));
        StringBuilder response = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            response.append(line);
        }

        reader.close();
        return response.toString();
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n");
    }

    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
    
    private String firstConfigured(String... values) {
        for (String value : values) {
            if (value != null && !value.trim().isEmpty()) {
                return value.trim();
            }
        }
        return null;
    }
}
