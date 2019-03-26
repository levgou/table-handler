<template>
  <div id="SettingsPage">
    <v-container fluid>
      <v-layout align-start justify-center>
        <v-flex xs6>
          <v-tabs fixed-tabs v-model="activeTab">
            <v-tab :key="1">General</v-tab>
            <v-tab :key="2">Messages</v-tab>
          </v-tabs>

          <v-tabs-items v-model="activeTab">
            <v-tab-item :key="1">
              <v-card class="settings-tab-card">
                <v-card-text>
                  <v-list subheader>
                    <v-subheader>Out Messages</v-subheader>
                    <v-list-tile
                      v-for="msg in socketMessages"
                      :key="msg.title"
                      avatar
                      @click="msgClicked(msg.title)"
                    >
                      <v-list-tile-avatar>
                        <img :src="msg.avatar">
                      </v-list-tile-avatar>

                      <v-list-tile-content>
                        <v-list-tile-title v-html="msg.title"></v-list-tile-title>
                      </v-list-tile-content>

                      <v-list-tile-action>
                        <v-layout align-center justify-space-between>
                          <v-icon
                            class="delete-msg"
                            @click.stop="deleteMsg($event, msg.title)"
                          >delete</v-icon>
                          <v-icon class="edit-msg" @click.stop="editMsg($event, msg.title)">edit</v-icon>
                        </v-layout>
                      </v-list-tile-action>
                    </v-list-tile>
                  </v-list>
                  <v-btn id="add-button" fab small @click="newMsgDialogVisible = true">
                    <v-icon small>add</v-icon>
                  </v-btn>

                  <NewMessageDialog
                    :is-visible="newMsgDialogVisible"
                    @dialog-closed="handleDialogClosed"
                  />
                  <!-- :avatars="avatars" -->
                </v-card-text>
              </v-card>
            </v-tab-item>

            <v-tab-item :key="2">
              <v-card class="settings-tab-card">
                <v-card-text>
                  <v-layout row wrap>
                    <v-flex xs12 md6>
                      <span>Scheme</span>
                      <v-switch primary label="Dark"></v-switch>
                    </v-flex>
                    <v-flex xs12 md6>
                      <span>Drawer</span>
                      <v-switch label="Clipped" primary></v-switch>
                      <v-switch label="Floating" primary></v-switch>
                      <v-switch label="Mini" primary></v-switch>
                    </v-flex>
                    <v-flex xs12 md6>
                      <span>Footer</span>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                      <v-switch label="Inset" primary></v-switch>
                    </v-flex>
                  </v-layout>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn flat>Cancel</v-btn>
                  <v-btn flat color="primary">Submit</v-btn>
                </v-card-actions>
              </v-card>
            </v-tab-item>
          </v-tabs-items>
        </v-flex>

        <v-flex xs6>
          <v-card flat>
            <div id="settings-editor">
              <v-btn
                id="save-button"
                fab
                small
                v-show="!editorReadOnly"
                @click.stop="saveEditorMessage()"
                :disabled="!isEditorContentValid"
              >
                <v-icon small>save</v-icon>
              </v-btn>
              <v-btn
                id="format-button"
                fab
                small
                v-show="!editorReadOnly"
                @click.stop="formatEditorMessage()"
                :disabled="!isEditorContentValid"
              >
                <v-icon small>format_paint</v-icon>
              </v-btn>
              <v-chip id="read-only-chip" text-color="white" v-show="editorReadOnly">Read Only
                <v-icon right>lock</v-icon>
              </v-chip>

              <v-snackbar
                v-model="snackbar"
                bottom
                color="success"
                :timeout="savedSuccessfullySnackbarTimeout"
              >Saved successfully
                <v-icon>cloud_done</v-icon>
              </v-snackbar>

              <editor
                ref="myEditor"
                v-model="editorContent"
                @init="editorInit"
                lang="json"
                theme="pastel_on_dark"
                height="100%"
                :options="settingsEditorOptions"
                @input="checkIsEditorContentValid()"
              ></editor>
            </div>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import NewMessageDialog from "./NewMessageDialog";
import JsonHelper from "@/mixins/JsonHelper";
import { mapState, mapMutations } from "vuex";

import { avatars } from "@/data_store.json";

export default {
  name: "SettingsPage",
  mixins: [JsonHelper],
  props: [],
  components: {
    editor: require("vue2-ace-editor"),
    NewMessageDialog
  },
  data: () => ({
    avatars: avatars,

    activeTab: 0,
    newMsgDialogVisible: false,

    editorContent: "",
    currentlyEditedMsg: null,
    editor: null,
    editorReadOnly: false,
    isEditorContentValid: true,
    settingsEditorOptions: { fontSize: 16 },

    snackbar: false,
    savedSuccessfullySnackbarTimeout: 2000,

    selectedAvatarKey: -1,
  }),
  computed: mapState(["socketMessages", "socketMessageContents"]),
  methods: {
    ...mapMutations(["setMessages", "setMessageContetns"]),
    handleDialogClosed: function(isValid, newMsgInfo) {
      if (isValid) {
        this.addNewMessageToList(
          newMsgInfo["name"],
          newMsgInfo["type"],
          newMsgInfo["avaterKey"]
        );
      }
      this.newMsgDialogVisible = false;
    },

    editorInit: function(editorInstance) {
      require("brace/ext/language_tools"); //language extension prerequsite...
      require("brace/mode/json");
      require("brace/theme/pastel_on_dark");

      this.editor = this.$refs.myEditor.editor;
    },

    msgClicked: function(msgTitle) {
      this.displayMessageInEditor(msgTitle);
      this.editorReadOnly = true;
      this.editor.setReadOnly(true);
    },

    displayMessageInEditor: function(msgTitle) {
      let msgContent = this.socketMessageContents[msgTitle];
      let prettyJson = "";

      if (msgContent !== "") {
        let json = JSON.parse(msgContent);
        prettyJson = JSON.stringify(json, null, 4);
      }

      this.editorContent = prettyJson;
    },

    checkIsEditorContentValid: function() {
      this.isEditorContentValid = this.isJsonStr(this.editorContent);
    },

    editMsg: function(event, msgTitle) {
      this.currentlyEditedMsg = msgTitle;
      this.displayMessageInEditor(msgTitle);
      this.editorReadOnly = false;
      this.editor.setReadOnly(false);
    },

    saveEditorMessage: function() {
      let newMessageContents = {...this.socketMessageContents};
      newMessageContents[this.currentlyEditedMsg] = this.editorContent

      this.setMessageContetns(newMessageContents);
      this.snackbar = true;
    },

    formatEditorMessage: function() {
      if (this.editorContent === "") {
        return;
      }

      let json = JSON.parse(this.editorContent);
      let prettyJson = JSON.stringify(json, null, 4);
      this.editorContent = prettyJson;
    },

    addNewMessageToList: function(msgName, msgType, msgAvatarKey) {
      let newMsg = {
        title: msgName,
        avatar: this.avatars[msgAvatarKey]
      };
      
      let newMessages = [...this.socketMessages, newMsg];
      let newMessageContents =  {...this.socketMessageContents};
      newMessageContents[msgName] = "";

      this.setMessages(newMessages);
      this.setMessageContetns(newMessageContents);

    },

    deleteMsg: function(event, msgTitle) {
      this.socketMessages = this.socketMessages.filter(
        msg => msg.title != msgTitle
      );
      // todo bug for sure
      this.messageContents.delete(msgTitle);
      this.persistLocalStorage();
    },

  }
};
</script>

