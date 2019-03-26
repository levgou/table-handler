<template>
  <div></div>
</template>


<script>
import { mapMutations } from "vuex";

export default {
  name: "SocketHandler",
  data: () => ({
    socket: null,
    isConnected: false,
    msgIndex: 1
  }),

  methods: {
    ...mapMutations(["setSockConnectionStatus", "appendMsgQueue"]),

    connect(connAddress) {
      this.socket = new WebSocket(connAddress);
      this.socket.onopen = () => {
        this.isConnected = true;
        this.setSockConnectionStatus(true);

        console.log("Connected to: ", connAddress);

        this.socket.onmessage = ({ data }) => {
          console.log({ event: "Recieved message", data });
          this.appendMsgQueue(this.wrapMsg(data, "in"));
        };
      };
    },

    disconnect() {
      this.socket.close();

      this.isConnected = false;
      this.setSockConnectionStatus(false);

      console.log("DC");
    },

    sendMessage(msg) {
      this.socket.send(msg);
      console.log({ event: "Sent message", data: msg });
      this.appendMsgQueue(this.wrapMsg(msg, "out"));
    },

    wrapMsg(msgStr, inOrOut) {
      return {
        content: msgStr,
        direction: inOrOut,
        time: this.curTimeStamp(),
        header: this.msgIndex++
      };
    },
    curTimeStamp() {
      return new Date().toJSON().substring(11, 19).replace(':', '.');
    }
  }
};
</script>
