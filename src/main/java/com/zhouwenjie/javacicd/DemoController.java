package com.zhouwenjie.javacicd;

import java.time.Instant;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/api/health")
    public Map<String, String> health() {
        return Map.of("status", "ok", "service", "backend");
    }

    @GetMapping("/api/message")
    public Map<String, String> message() {
        return Map.of(
                "message", "Hello from backend",
                "timestamp", Instant.now().toString());
    }
}
