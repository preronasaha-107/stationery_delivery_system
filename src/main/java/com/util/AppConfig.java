package com.util;

public final class AppConfig {

    private AppConfig() {
    }

    public static String get(String propertyKey, String environmentKey) {
        String value = normalize(System.getProperty(propertyKey));
        if (value != null) {
            return value;
        }

        return normalize(System.getenv(environmentKey));
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
}
