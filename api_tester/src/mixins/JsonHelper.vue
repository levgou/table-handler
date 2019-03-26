<script>
export default {
  name: "JsonHelper",
  methods: {
    isJsonStr(str) {
      try {
        JSON.parse(str);
      } catch (e) {
        return false;
      }
      return true;
    },
    jsonPrettify(jsonStr) {
      let json = JSON.parse(jsonStr);
      let prettyJson = JSON.stringify(json, null, 4);

      return prettyJson;
    },
    
    oneLineJson(jsonStr) {
      let json = JSON.parse(jsonStr);
      let plainJson = JSON.stringify(json);

      return plainJson;
    },
  },
};
</script>
