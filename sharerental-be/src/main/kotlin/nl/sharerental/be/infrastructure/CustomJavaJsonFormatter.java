package nl.sharerental.be.infrastructure;

import ch.qos.logback.contrib.jackson.JacksonJsonFormatter;

import java.io.IOException;
import java.util.Map;

public class CustomJavaJsonFormatter extends JacksonJsonFormatter {
    @Override
    public String toJsonString(Map map) throws IOException {
        map.put("severity", map.get("level"));
        map.put("logging.googleapis.com/labels", map.get("mdc"));
        map.put("logging.googleapis.com/sourceLocation", map.get("logger"));
        map.remove("level");
        map.remove("mdc");
        map.remove("logger");
        return super.toJsonString(map);
    }
}
