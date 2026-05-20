package com.util;

public final class PhoneNumberUtil {

    private PhoneNumberUtil() {
    }

    public static boolean isValidIndianPhone(String phoneNumber) {
        return normalizeDigits(phoneNumber) != null;
    }

    public static String normalizeForStorage(String phoneNumber) {
        String digits = normalizeDigits(phoneNumber);
        if (digits == null) {
            return null;
        }

        return "+91 " + digits.substring(0, 5) + " " + digits.substring(5);
    }

    public static String normalizeForDisplay(String phoneNumber) {
        String normalized = normalizeForStorage(phoneNumber);
        if (normalized != null) {
            return normalized;
        }

        return phoneNumber == null ? "" : phoneNumber.trim();
    }

    private static String normalizeDigits(String phoneNumber) {
        if (phoneNumber == null) {
            return null;
        }

        String digits = phoneNumber.replaceAll("\\D", "");

        if (digits.startsWith("91") && digits.length() == 12) {
            digits = digits.substring(2);
        }

        if (digits.length() != 10) {
            return null;
        }

        char firstDigit = digits.charAt(0);
        if (firstDigit < '6' || firstDigit > '9') {
            return null;
        }

        return digits;
    }
}
