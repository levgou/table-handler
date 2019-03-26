<template>
  <div>
    <v-card class="comm-tab-card">
      <v-card-text>
        <v-container fluid>
          <v-layout row>
            <v-flex>
              <v-select :items="hosts" label="Host" v-model="selectedHost">
                <template slot="selection" slot-scope="data">
                  <v-flex xs2>
                    <v-avatar size="25px">
                      <img src="https://material.io/tools/icons/static/ic_icons_192px_light.svg">
                    </v-avatar>
                  </v-flex>
                  <v-flex class="ml-1" v-html="data.item"></v-flex>
                </template>

                <template slot="item" slot-scope="data">
                  <v-list-tile-avatar>
                    <img src="https://material.io/tools/icons/static/ic_icons_192px_light.svg">
                  </v-list-tile-avatar>
                  <v-list-tile-content>
                    <v-list-tile-title v-html="data.item"></v-list-tile-title>
                  </v-list-tile-content>
                </template>
              </v-select>
            </v-flex>

            <v-flex v-if="!isSocketConnected" shrink class="conn-button">
              <v-btn
                medium
                :loading="loading3"
                :disabled="loading3"
                color="#66bb6a"
                class="white--text"
                @click="loader = 'loading3'; connectSocket()"
              >
                Connect
                <v-icon right dark>cloud_upload</v-icon>
              </v-btn>
            </v-flex>

            <v-flex v-if="isSocketConnected" shrink class="conn-button">
              <v-btn
                medium
                :loading="loading2"
                :disabled="loading2"
                color="#ef5350"
                class="white--text"
                @click="loader = 'loading2'; disconnectSocket()"
              >
                Disconnect
                <v-icon right dark>games</v-icon>
              </v-btn>
            </v-flex>
          </v-layout>
          <!-- <v-divider class="mah-divider"></v-divider> -->

          <v-layout row>
            <v-flex xs12>
              <v-select :items="socketMessages" label="Message" @input="handleMsgSelectInput">
                <template slot="selection" slot-scope="data">
                  <v-flex xs2>
                    <v-avatar size="25px">
                      <img :src="data.item.avatar">
                    </v-avatar>
                  </v-flex>
                  <v-flex class="ml-1">{{ data.item.title }}</v-flex>
                </template>

                <template slot="item" slot-scope="data">
                  <v-list-tile-avatar>
                    <img :src="data.item.avatar">
                  </v-list-tile-avatar>
                  <v-list-tile-content>
                    <v-list-tile-title>{{ data.item.title }}</v-list-tile-title>
                  </v-list-tile-content>
                </template>
              </v-select>
            </v-flex>
          </v-layout>

          <v-divider class="mah-divider"></v-divider>
          <div id="out-editor-box">
            <v-btn
              id="send-msg-button"
              fab
              small
              @click.stop="sendMsg()"
              :disabled="!isEditorContentValid"
            >
              <v-icon small>send</v-icon>
            </v-btn>

            <editor
              id="out-editor"
              ref="outEditor"
              v-model="editorContent"
              @init="editorInit"
              lang="json"
              theme="pastel_on_dark"
              height="100%"
              :options="editorOptions"
              @input="checkIsEditorContentValid()"
            ></editor>
          </div>
        </v-container>
      </v-card-text>
    </v-card>

    <div class="light-thingy" v-show="!isSocketConnected">
      <PulsingLight pulseClass="pulse-red"/>
    </div>
    <div class="light-thingy" v-show="isSocketConnected">
      <PulsingLight pulseClass="pulse-green"/>
    </div>

    <SocketHandler ref="socketHandler"></SocketHandler>
  </div>
</template>

<script>
import PulsingLight from "./PulsingLight";
import { mapState } from "vuex";
import JsonHelper from "@/mixins/JsonHelper";
import SocketHandler from "./SocketHandler";

export default {
  name: "SendMsgPanel",
  components: {
    PulsingLight,
    editor: require("vue2-ace-editor"),
    SocketHandler
  },
  mixins: [JsonHelper],
  data: () => ({
    hosts: ["localhost", "127.0.0.1", "ws://demos.kaazing.com/echo"],

    isEditorContentValid: false,
    editorContent: "",
    editor: null,
    editorOptions: { fontSize: 16 },

    // todo refacotr
    loader: null,
    loading2: false,
    loading3: false,

    socketHandler: null,

    selectedHost: null,
    selectedMsg: null,
  }),
  methods: {
    editorInit(editorInstance) {
      require("brace/ext/language_tools"); //language extension prerequsite...
      require("brace/mode/json");
      require("brace/theme/pastel_on_dark");

      this.editor = this.$refs.outEditor.editor;
    },
    checkIsEditorContentValid() {
      this.isEditorContentValid = this.isJsonStr(this.editorContent);
    },
    handleMsgSelectInput(msg) {
      this.editorContent = this.jsonPrettify(
        this.socketMessageContents[msg.title]
      );
    },
    connectSocket() {
      console.log(this.selectedHost);
      this.socketHandler.connect(this.selectedHost);
    },

    disconnectSocket() {
      this.socketHandler.disconnect();
    },

    sendMsg() {
      let jsonMsg = this.oneLineJson(this.editorContent);
      this.socketHandler.sendMessage(jsonMsg);
    }
  },
  computed: mapState(["socketMessages", "socketMessageContents", "isSocketConnected"]),

  watch: {
    loader() {
      const l = this.loader;
      this[l] = !this[l];

      setTimeout(() => (this[l] = false), 3000);

      this.loader = null;
    }
  },
  mounted() {
    this.socketHandler = this.$refs.socketHandler;
  }
};
</script>

<style>
#out-editor-box {
  height: 57.5vh;
}

#send-msg-button {
  position: absolute;
  bottom: 25px;
  right: 50px;
  z-index: 1;
  background-color: rgba(102, 187, 106, 0.85);
}

.custom-loader {
  animation: loader 1s infinite;
  display: flex;
}
.mah-divider {
  margin-top: 15px;
  margin-bottom: 10px;
}

.conn-button {
  padding-top: 10px;
  padding-left: 5px;
}

.light-thingy {
  position: fixed;
  top: 23px;
  right: 20px;
  z-index: 3;
}

@-moz-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-webkit-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@-o-keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
@keyframes loader {
  from {
    transform: rotate(0);
  }
  to {
    transform: rotate(360deg);
  }
}
</style>


