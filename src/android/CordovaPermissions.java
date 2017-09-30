package org.tumoc.permissions;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import android.content.Context;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class CordovaPermissions extends CordovaPlugin {

    private Map<String, String> permissions;

    public CordovaPermissions() {

        this.permissions = new HashMap<String, String>();

        this.permissions.put("notification", "OP_POST_NOTIFICATION");

        this.permissions.put("contacts_read", "OP_READ_CONTACTS");
        this.permissions.put("contacts_write", "OP_WRITE_CONTACTS");

        this.permissions.put("calendar_read", "OP_READ_CALENDAR");
        this.permissions.put("calendar_write", "OP_WRITE_CALENDAR");

        this.permissions.put("vibrate", "OP_VIBRATE");

    }

    private Context getApplicationContext() {
        return this.cordova.getActivity().getApplicationContext();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            JSONArray requestedPermissions = args.getJSONArray(0);
            this.get(requestedPermissions, callbackContext);
            return true;
        }
        return false;
    }

    private void get(JSONArray requestedPermissions, CallbackContext callbackContext) {

        JSONObject json;
        String key;

        try {

            json = new JSONObject();

            for (int i = 0; i < requestedPermissions.length(); i++) {

                key = requestedPermissions.getString(i);

                if (! this.permissions.containsKey(key)) {
                    throw new UnknownError("unknown permission key");
                }

                json.put(key,
                        PermissionUtils.hasPermission(
                            getApplicationContext(),
                            this.permissions.get(key)
                        )
                );

            }

            callbackContext.success(json);

        } catch (UnknownError e) {
            callbackContext.error("Err UNKNOWN - " + e.getMessage());
        } catch (JSONException e) {
            callbackContext.error("Err JSON - " + e.getMessage());
        }

    }
}
