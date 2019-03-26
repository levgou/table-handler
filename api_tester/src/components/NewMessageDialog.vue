<template>
  <div class="NewMessageDialog">
    <v-dialog v-model="amIvisible" width="40%" @input="emitDialogClosed()">
      <v-card>
        <v-card-title>
          <span class="headline">New Message</span>
        </v-card-title>

        <v-card-text>
          <v-container grid-list-xl>
            <v-layout wrap>
              <v-flex xs12 sm6>
                <v-text-field label="Mesage Name" required v-model="dialogMsgName"></v-text-field>
              </v-flex>
              <v-flex xs12 sm6>
                <v-select
                  :items="['User Message', 'Server Message']"
                  label="Message Type"
                  required
                  v-model="dialogMsgType"
                ></v-select>
              </v-flex>
            </v-layout>
          </v-container>

          <div style="height: 200px; overflow-y: auto">
            <v-container grid-list-lg fluid>
              <v-layout row wrap>
                <v-flex v-for="(avatar, index) in avatars" :key="index" xs2>
                  <v-avatar>
                    <v-img
                      class="elevation-10"
                      :class="{ 'avatar-img-selected': (selectedAvatarKey === index), 'avatar-img':  (selectedAvatarKey !== index)}"
                      :src="avatar"
                      height="50px"
                      @click="avatarClick($event, index)"
                      @mouseenter="avatarMouseEnter($event, index)"
                      @mouseleave="avatarMouseLeave($event, index)"
                    ></v-img>
                  </v-avatar>
                </v-flex>
              </v-layout>
            </v-container>
          </div>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" flat @click="dialog = false; handleDialogOk()">OK</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>


<script>
import { avatars } from '@/data_store.json'

export default {
  name: "NewMessageDialog",
  props: ["isVisible"],
  data: () => ({
    amIvisible: false,
    selectedAvatarKey: -1,
    dialogMsgName: "",
    dialogMsgType: "",
    avatars: avatars,
  }),
  watch: {
    isVisible(newValue, oldValue) {
      if (newValue) {
        this.resetDialogContent();
      }
      this.amIvisible = newValue;
    }
  },

  methods: {
    resetDialogContent: function() {
      this.selectedAvatarKey = -1;
      this.dialogMsgName = "";
      this.dialogMsgType = "";
    },

    handleDialogOk: function() {
      if (this.dialogContentIsValid()) {
        console.log("Adding message!");
        this.$emit("dialog-closed", true, {
          name: this.dialogMsgName,
          type: this.dialogMsgType,
          avaterKey: this.selectedAvatarKey
        });
      }
    },

    dialogContentIsValid: function() {
      if (this.selectedAvatarKey === -1) {
        return false;
      }
      if (this.dialogMsgName === "") {
        return false;
      }
      if (this.dialogMsgType !== "User Message") {
        return false;
      }
      return true;
    },

    avatarMouseEnter: function(event, avatarIndex) {
      if (event.target.classList.contains("elevation-10")) {
        console.log("removinf - enter");
        event.target.classList.remove("elevation-10");
      }
    },

    avatarMouseLeave: function(event, avatarIndex) {
      if (this.selectedAvatarKey !== avatarIndex) {
        // event.target.classList.add("elevation-10");
        console.log("add - leave");
      }
    },

    avatarClick: function(event, avatarIndex) {
      this.selectedAvatarKey = avatarIndex;
      console.log("removinf - click");

      let curElement = event.target;
      while (curElement !== null) {
        while (curElement.classList.contains("elevation-10")) {
          curElement.classList.remove("elevation-10");
        }
        curElement = curElement.parentElement;
      }
    },
    emitDialogClosed: function() {
      this.$emit("dialog-closed", false, {});
    }
  }
};
</script>


<style scoped>
.avatar-img:hover {
  -webkit-box-shadow: 0px 0px 30px 0px rgba(64, 115, 177, 0.67);
  -moz-box-shadow: 0px 0px 30px 0px rgba(64, 115, 177, 0.67);
  box-shadow: 0px 0px 30px 0px rgba(64, 115, 177, 0.67);
  background-color: rgba(64, 115, 177, 0.4);
}

.avatar-img-selected {
  -webkit-box-shadow: 0px 0px 30px 10px rgba(64, 115, 177, 1);
  -moz-box-shadow: 0px 0px 30px 10px rgba(64, 115, 177, 1);
  box-shadow: 0px 0px 30px 10px rgba(64, 115, 177, 1);
}
</style>
