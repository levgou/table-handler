<template>
  <v-app id="App" :dark="dark">
    <v-navigation-drawer v-model="primaryDrawer.model" clipped absolute overflow app>
      <v-list class="pt-4">
        <v-list-tile v-for="item in drawerItems" :key="item.title" :to="{path: item.path}">
          <v-list-tile-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-tile-action>

          <v-list-tile-content>
            <v-list-tile-title>{{ item.title }}</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <v-toolbar clipped-left app absolute>
      <v-toolbar-side-icon @click.stop="primaryDrawer.model = !primaryDrawer.model"></v-toolbar-side-icon>
      <v-toolbar-title>S H T A</v-toolbar-title>
    </v-toolbar>

    <v-content>
      <!-- route outlet -->
      <router-view></router-view>
    </v-content>

    <v-footer :inset="footer.inset" app>
      <span class="px-3">&copy; {{ new Date().getFullYear() }}</span>
    </v-footer>
  </v-app>
</template>

<script>
import NewMessageDialog from "./components/NewMessageDialog";

export default {
  name: "App",
  components: {
    editor: require("vue2-ace-editor"),
    NewMessageDialog
  },
  data: () => ({
    dark: true,
    snackbar: false,
    savedSuccessfullySnackbarTimeout: 2000,
    newMsgDialogVisible: false,

    primaryDrawer: {
      model: null,
      type: "default (no property)"
    },
    footer: {
      inset: false
    },
    drawerItems: [
      { title: "Home", icon: "dashboard", path: "/" },
      { title: "Communicate", icon: "import_export", path: "/comm" },
      { title: "Settings", icon: "settings", path: "/settings" }
    ],
    messages: null,

    selectedAvatarKey: -1,
    messageContents: null
  }),
  computed: {},
  methods: {}
};
</script>


<style >
#save-button {
  position: absolute;
  bottom: 5px;
  right: 1px;
  z-index: 1;
  background-color: rgba(64, 115, 177, 0.5);
}

#save-button:hover {
  background-color: rgba(64, 115, 177, 1);
}

#format-button {
  position: absolute;
  bottom: 60px;
  right: 1px;
  z-index: 1;
  background-color: rgba(255, 141, 0, 0.5);
}

#read-only-chip {
  background-color: rgba(255, 141, 0, 0.5);
  position: absolute;
  top: 25px;
  right: 1px;
  z-index: 1;
}

#add-button {
  position: absolute;
  bottom: 20px;
  right: 10px;
  z-index: 1;
  background-color: rgba(64, 115, 177, 1);
}

.theme--dark.v-icon {
  color: #9e9e9e;
}

.theme--dark.v-icon.delete-msg:hover {
  color: brown;
}

.theme--dark.v-icon.edit-msg:hover {
  color: green;
}

#settings-editor {
  height: 81vh;
}


.settings-tab-card {
  height: 75vh;
  overflow-y: auto;
}

.comm-tab-card {
  height: 83vh;
}

::-webkit-scrollbar-track-piece {
  border-radius: 10px;
  background-color: rgba(48, 48, 48, 0.5);
}

::-webkit-scrollbar {
  border-radius: 10px;
  width: 6px;
}

::-webkit-scrollbar-thumb {
  border-radius: 10px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
  background-color: #4073b1;
}
</style>
