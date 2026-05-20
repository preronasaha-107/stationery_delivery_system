package com.util;

import java.io.InputStream;
import java.util.Properties;

public final class AppConfig {

    private static final Properties FILE_PROPERTIES = loadFileProperties();

    private AppConfig() {
    }

    public static String get(String propertyKey, String environmentKey) {
        String value = normalize(System.getProperty(propertyKey));
        if (value != null) {
            return value;
        }

        value = normalize(System.getenv(environmentKey));
        if (value != null) {
            return value;
        }

        value = normalize(FILE_PROPERTIES.getProperty(propertyKey));
        if (value != null) {
            return value;
        }

        return normalize(FILE_PROPERTIES.getProperty(environmentKey));
    }

    public static String require(String propertyKey, String environmentKey, String label) {
        String value = get(propertyKey, environmentKey);
        if (value == null) {
            throw new IllegalStateException(label + " is not configured.");
        }
        return value;
    }

    public static int getInt(String propertyKey, String environmentKey, int defaultValue) {
        String value = get(propertyKey, environmentKey);
        if (value == null) {
            return defaultValue;
        }

        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private static String normalize(String value) {
        if (value == null) {
            return null;
        }

        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private static Properties loadFileProperties() {
        Properties properties = new Properties();

        try {
            InputStream inputStream = AppConfig.class.getClassLoader().getResourceAsStream("app.properties");
            if (inputStream != null) {
                properties.load(inputStream);
                inputStream.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return properties;
    }
}
