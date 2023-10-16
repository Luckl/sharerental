package nl.sharerental.be.infrastructure;

import ch.qos.logback.contrib.jackson.JacksonJsonFormatter;

import java.io.IOException;
import java.util.Map;

/**
 * Java since in kotlin we get compiler errors
 */
public class CustomJavaJsonFormatter extends JacksonJsonFormatter {
    @Override
    public String toJsonString(Map map) throws IOException {
        map.put("severity", map.get("level"));
        map.put("logging.googleapis.com/labels", map.get("mdc"));
        map.put("logging.googleapis.com/sourceLocation", map.get("logger"));
        map.put("logging.googleapis.com/spanId", ((Map) map.get("mdc")).get("spanId"));
        map.put("logging.googleapis.com/trace", ((Map) map.get("mdc")).get("trace"));
        map.remove("level");
        map.remove("mdc");
        map.remove("logger");
        return super.toJsonString(map);
    }
}
