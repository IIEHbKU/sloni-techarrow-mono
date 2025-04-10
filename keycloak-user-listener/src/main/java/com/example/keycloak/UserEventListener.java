package com.example.keycloak;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import org.keycloak.events.Event;
import org.keycloak.events.EventListenerProvider;
import org.keycloak.events.EventType;
import org.keycloak.events.admin.AdminEvent;
import org.keycloak.events.admin.OperationType;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.keycloak.models.RealmModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserEventListener implements EventListenerProvider {

    private static final String USER_REGISTER_URL = "http://api.penki.tech/api/users/register";
    private static final String SUPERADMIN_URL = "http://api.penki.tech/api/superadmin";
    private final KeycloakSession session;
    private static final Logger logger = LoggerFactory.getLogger(UserEventListener.class);

    public UserEventListener(KeycloakSession session) {
        this.session = session;
    }

    @Override
    public void onEvent(Event event) {
        if (event.getType().equals(EventType.REGISTER)) {
            RealmModel realm = session.getContext().getRealm();
            UserModel user = session.users().getUserById(realm, event.getUserId());
            Map<String, String> userData = new HashMap<>();
            userData.put("id", user.getId());
            userData.put("userName", user.getUsername());
            userData.put("email", user.getEmail());
            logger.info("Registering user: {}", user.getUsername());
            sendPostRequest(USER_REGISTER_URL, userData);
        }
    }

    @Override
    public void onEvent(AdminEvent adminEvent, boolean includeRepresentation) {
        String userId = adminEvent.getResourcePath().split("/")[1];
        UserModel user = session.users().getUserById(session.getContext().getRealm(), userId);
        if (adminEvent.getOperationType().equals(OperationType.CREATE)) {
            Map<String, String> userData = new HashMap<>();
            userData.put("id", user.getId());
            userData.put("userName", user.getUsername());
            userData.put("email", user.getEmail());
            logger.info("Creating user: {}", user.getUsername());
            sendPostRequest(SUPERADMIN_URL + "/create", userData);
        } else if (adminEvent.getOperationType().equals(OperationType.UPDATE)) {
            Map<String, String> userData = new HashMap<>();
            userData.put("id", user.getId());
            userData.put("email", user.getEmail());
            logger.info("Updating user: {}", user.getUsername());
            sendPatchRequest(userData);
        } else if (adminEvent.getOperationType().equals(OperationType.DELETE)) {
            logger.info("Deleting user with user_id: {}", userId);
            sendDeleteRequest(userId);
        }
    }

    private void sendPostRequest(String url, Map<String, String> data) {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost post = new HttpPost(url);
            String json = new com.google.gson.Gson().toJson(data);
            StringEntity entity = new StringEntity(json);
            post.setEntity(entity);
            post.setHeader("Accept", "application/json");
            post.setHeader("Content-type", "application/json");
            HttpResponse response = client.execute(post);
            int statusCode = response.getStatusLine().getStatusCode();
            String responseBody = response.getEntity() != null ? EntityUtils.toString(response.getEntity()) : "No content";
            logger.info("POST request to {} completed with status code: {} and response: {}", url, statusCode, responseBody);
        } catch (IOException e) {
            logger.error("Error sending POST request to {}", url, e);
        }
    }

    private void sendPatchRequest(Map<String, String> data) {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPatch patch = new HttpPatch(UserEventListener.SUPERADMIN_URL + "/update");
            String json = new com.google.gson.Gson().toJson(data);
            StringEntity entity = new StringEntity(json);
            patch.setEntity(entity);
            patch.setHeader("Accept", "application/json");
            patch.setHeader("Content-type", "application/json");
            HttpResponse response = client.execute(patch);
            int statusCode = response.getStatusLine().getStatusCode();
            String responseBody = response.getEntity() != null ? EntityUtils.toString(response.getEntity()) : "No content";
            logger.info("PATCH request to {}/update completed with status code: {} and response: {}", UserEventListener.SUPERADMIN_URL, statusCode, responseBody);
        } catch (IOException e) {
            logger.error("Error sending PATCH request to {}/update", UserEventListener.SUPERADMIN_URL, e);
        }
    }

    private void sendDeleteRequest(String userId) {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpDelete delete = new HttpDelete(UserEventListener.SUPERADMIN_URL + "/delete/" + userId);
            HttpResponse response = client.execute(delete);
            int statusCode = response.getStatusLine().getStatusCode();
            String responseBody = response.getEntity() != null ? EntityUtils.toString(response.getEntity()) : "No content";
            logger.info("DELETE request to {}/delete/{} completed with status code: {} and response: {}", UserEventListener.SUPERADMIN_URL, userId, statusCode, responseBody);
        } catch (IOException e) {
            logger.error("Error sending DELETE request to {}/delete/{}", UserEventListener.SUPERADMIN_URL, userId, e);
        }
    }

    @Override
    public void close() {
    }
}
