<template>
  <v-container fluid>
    <v-layout align-start justify-center>
      <v-flex xs6>
        <SendMsgPanel style="margin-right:10px"/>
      </v-flex>

      <v-flex xs6>
        <ResponsePanel style="margin-left:10px"/>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import SendMsgPanel from "./SendMsgPanel";
import ResponsePanel from "./ResponsePanel";

export default {
  name: "CommPane",
  components: {
    SendMsgPanel,
    ResponsePanel
  }
};
</script>
