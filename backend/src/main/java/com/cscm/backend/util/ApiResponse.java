package com.cscm.backend.util;

import lombok.*;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ApiResponse<T> {

    private boolean success;
    private String message;
    private T data;

    public static <T> ApiResponse<T> success(T data, String message) {
        return ApiResponse.<T>builder().success(true).message(message).data(data).build();
    }

    public static <T> ApiResponse<T> success(T data) {
        return success(data, "Succès");
    }

    public static ApiResponse<Void> error(String message) {
        return ApiResponse.<Void>builder().success(false).message(message).build();
    }

    public static ApiResponse<Void> ok(String message) {
        return ApiResponse.<Void>builder().success(true).message(message).build();
    }
}
