package com.venx2.util;

import java.util.UUID;

public class CodeGenerator {

    private CodeGenerator() {}

    public static String generateCode() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 12).toUpperCase();
    }
}
