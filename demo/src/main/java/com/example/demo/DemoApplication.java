package com.example.demo;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}

@RestController
class HelloWorldController {

    @GetMapping("/")
    public String home() {
        StringBuilder response = new StringBuilder();

        // Current Date and Time
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDateTime = currentDateTime.format(formatter);

        // Hostname and IP Address
        String hostname = "Unknown";
        String ipAddress = "Unknown";
        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            hostname = inetAddress.getHostName();
            ipAddress = inetAddress.getHostAddress();
        } catch (UnknownHostException e) {
            // Log the error for debugging purposes
            System.err.println("Failed to get host information: " + e.getMessage());
        }

        // Instance Directory
        String instanceDir = System.getProperty("user.dir");

        // Generate a random session ID (for demo purposes)
        String sessionId = UUID.randomUUID().toString();

        // Build the response
        response.append("<h1>Hello, World from Blue-Green Deployment!!!</h1>")
                .append("<p><b>Hostname:</b> ").append(hostname).append("</p>")
                .append("<p><b>IP Address:</b> ").append(ipAddress).append("</p>")
                .append("<p><b>Instance Directory:</b> ").append(instanceDir).append("</p>")
                .append("<p><b>Instance ID:</b> ").append(sessionId).append("</p>")
                .append("<p><b>Current time:</b> ").append(formattedDateTime).append("</p>");

        return response.toString();
    }
}
