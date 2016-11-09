package com.google.gson;

import java.lang.reflect.Type;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

@SuppressWarnings("rawtypes")
public class MyMapTypeAdapter implements JsonSerializer<Map>,
		JsonDeserializer<Map>, InstanceCreator<Map> {

	@SuppressWarnings("unchecked")
	public JsonElement serialize(Map src, Type typeOfSrc,
			JsonSerializationContext context) {
		JsonObject map = new JsonObject();

		for (Map.Entry entry : (Set<Map.Entry>) src.entrySet()) {
			Object value = entry.getValue();

			JsonElement valueElement;
			if (value == null) {
				valueElement = JsonNull.createJsonNull();
			} else {
				Type childType = value.getClass(); // 这一句改了, 始终都是按实际类型拿
				valueElement = context.serialize(value, childType);
			}
			map.add(String.valueOf(entry.getKey()), valueElement);
		}
		return map;
	}

	public Map deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		// Use ObjectConstructor to create instance instead of hard-coding a
		// specific type.
		// This handles cases where users are using their own subclass of
		// Map.
		@SuppressWarnings("unchecked")
		Map<Object, Object> map = constructMapType(typeOfT, context);
		/*TypeInfoMap mapTypeInfo = new TypeInfoMap(typeOfT);
		for (Map.Entry<String, JsonElement> entry : json.getAsJsonObject().entrySet()) {
			Object key = context.deserialize(new JsonPrimitive(entry.getKey()),
					mapTypeInfo.getKeyType());
			Object value = context.deserialize(entry.getValue(),
					mapTypeInfo.getValueType());
			map.put(key, value);
		}*/
		return map;
	}

	private Map constructMapType(Type mapType, JsonDeserializationContext context) {
		JsonDeserializationContextDefault contextImpl = (JsonDeserializationContextDefault) context;
		ObjectConstructor objectConstructor = contextImpl.getObjectConstructor();
		return (Map) objectConstructor.construct(mapType);
	}

	public Map createInstance(Type type) {
		return new LinkedHashMap();
	}

	@Override
	public String toString() {
		return MyMapTypeAdapter.class.getSimpleName();
	}
}
