<template>
  <div>
    <v-card class="comm-tab-card">
      <v-card-text>
        <div id="in-out-msgs">
          <!-- <v-list two-line>
          <template v-for="(item, index) in items">
            <v-subheader v-if="item.header" :key="item.header">{{ item.header }}</v-subheader>

            <v-divider v-else-if="item.divider" :key="index" :inset="item.inset"></v-divider>

            <v-list-tile v-else :key="item.title" avatar @click>
              <v-list-tile-avatar>
                <img :src="item.avatar">
              </v-list-tile-avatar>

              <v-list-tile-content>
                <v-list-tile-title v-html="item.title"></v-list-tile-title>
                <v-list-tile-sub-title v-html="item.subtitle"></v-list-tile-sub-title>
              </v-list-tile-content>
            </v-list-tile>
          </template>
          </v-list>-->

          <v-list two-line>
            <template v-for="(wrappedMsg, index) in socketMsgsQueue">
              <v-list-tile :key="wrappedMsg.header" avatar @click.stop="populateInOutEditor(index)">
                <v-list-tile-avatar :color="wrappedMsg.direction === 'out' ? 'pink' : 'indigo'">
                  <v-icon
                    size="20px"
                  >{{ wrappedMsg.direction === 'out' ? 'phone_forwarded' : 'phone_callback' }}</v-icon>
                </v-list-tile-avatar>

                <v-list-tile-content>
                  <v-list-tile-title>{{ wrappedMsg.time }} : &nbsp;&nbsp; {{ wrappedMsg.header }}</v-list-tile-title>
                  <v-list-tile-sub-title v-html="wrappedMsg.content"></v-list-tile-sub-title>
                </v-list-tile-content>
              </v-list-tile>
              <v-divider v-if="index !== socketMsgsQueue.length - 1" :key="index + 1000" inset></v-divider>
            </template>
          </v-list>

          <v-btn
            id="clear-list-button"
            fab
            small
            @click.stop="clearMsgQueue(); editorContent=''"
            :disabled="socketMsgsQueue.length === 0"
          >
            <v-icon medium>clear_all</v-icon>
          </v-btn>
        </div>
        <v-divider id="in-out-divider"></v-divider>
        <div id="in-out-editor-box">
          <editor
            id="in-out-editor"
            ref="outInEditor"
            v-model="editorContent"
            @init="editorInit"
            lang="json"
            theme="pastel_on_dark"
            height="100%"
            :options="editorOptions"
          ></editor>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import JsonHelper from "@/mixins/JsonHelper";

export default {
  name: "ResponsePanel",
  components: {
    editor: require("vue2-ace-editor")
  },
  mixins: [JsonHelper],
  data: () => ({
    iInOutsEditorContentValid: false,
    editorContent: "",
    inOutEditor: null,

    editorOptions: { fontSize: 16 }
  }),
  computed: mapState(["socketMsgsQueue"]),
  methods: {
    ...mapMutations(["clearMsgQueue"]),

    editorInit: function(editorInstance) {
      require("brace/ext/language_tools"); //language extension prerequsite...
      require("brace/mode/json");
      require("brace/theme/pastel_on_dark");

      this.inOutEditor = this.$refs.outInEditor.editor;
    },

    populateInOutEditor(queueIndex) {
      this.editorContent = this.jsonPrettify(
        this.socketMsgsQueue[queueIndex]["content"]
      );
    }
  }
};
</script>

</<style scoped>

#clear-list-button {
  position: absolute;
  bottom: 41vh;
  right: 20px;
  z-index: 1;
  background-color: rgba(226, 162, 23, 0.85);
}

#in-out-editor-box {
  height: 39vh;

}
#in-out-msgs {
  height: 39vh;
  overflow: auto;
}

#in-out-divider {
  margin-top: 10px;
  margin-bottom: 10px;

}

</style>
