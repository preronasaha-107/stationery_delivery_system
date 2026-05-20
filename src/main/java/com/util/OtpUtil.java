package com.util;

import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

public final class OtpUtil {

    public static final String SESSION_OTP_CODE = "authOtpCode";
    public static final String SESSION_OTP_EXPIRY = "authOtpExpiry";
    public static final String SESSION_OTP_PURPOSE = "authOtpPurpose";
    public static final String SESSION_OTP_EMAIL = "authOtpEmail";
    public static final String SESSION_PENDING_REGISTER_USER = "pendingRegisterUser";
    public static final String SESSION_PENDING_LOGIN_USER = "pendingLoginUser";

    private static final SecureRandom RANDOM = new SecureRandom();

    private OtpUtil() {
    }

    public static String generateOtp() {
        int number = 100000 + RANDOM.nextInt(900000);
        return String.valueOf(number);
    }

    public static long createExpiryTime() {
        return System.currentTimeMillis() + (getExpiryMinutes() * 60L * 1000L);
    }

    public static int getExpiryMinutes() {
        return AppConfig.getInt("otp.expiry.minutes", "OTP_EXPIRY_MINUTES", 5);
    }

    public static boolean isExpired(Long expiryTime) {
        return expiryTime == null || System.currentTimeMillis() > expiryTime.longValue();
    }

    public static void storeOtp(HttpSession session, String purpose, String email, String otp, long expiryTime) {
        session.setAttribute(SESSION_OTP_PURPOSE, purpose);
        session.setAttribute(SESSION_OTP_EMAIL, email);
        session.setAttribute(SESSION_OTP_CODE, otp);
        session.setAttribute(SESSION_OTP_EXPIRY, Long.valueOf(expiryTime));
    }

    public static void clearOtp(HttpSession session) {
        session.removeAttribute(SESSION_OTP_PURPOSE);
        session.removeAttribute(SESSION_OTP_EMAIL);
        session.removeAttribute(SESSION_OTP_CODE);
        session.removeAttribute(SESSION_OTP_EXPIRY);
    }

    public static void clearPendingAuth(HttpSession session) {
        clearOtp(session);
        session.removeAttribute(SESSION_PENDING_REGISTER_USER);
        session.removeAttribute(SESSION_PENDING_LOGIN_USER);
    }

    public static String maskEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return "";
        }

        String trimmedEmail = email.trim();
        int separatorIndex = trimmedEmail.indexOf('@');

        if (separatorIndex <= 1) {
            return trimmedEmail;
        }

        String localPart = trimmedEmail.substring(0, separatorIndex);
        String domainPart = trimmedEmail.substring(separatorIndex);

        if (localPart.length() <= 2) {
            return localPart.charAt(0) + "*" + domainPart;
        }

        return localPart.substring(0, 2) + "****" + domainPart;
    }
}
