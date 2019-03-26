<template>
  <div :id="editorId" style="width: 100%; height: 100%;"></div>
</template>

<script>
export default {
  name: "CodeEditor",
  props: ["editorId", "content", "lang", "theme"],
  data() {
    return {
      editor: Object,
      beforeContent: ""
    };
  },
  components: {
    editor: require("vue2-ace-editor")
  },
  mounted() {
    const lang = this.lang || "text";
    const theme = this.theme || "github";

    this.editor = window.ace.edit(this.editorId);
    this.editor.setValue(this.content, 1);

    // mode-xxx.js or theme-xxx.jsがある場合のみ有効
    require(`ace/theme/${theme}`)


    
    this.editor.getSession().setMode(`ace/mode/${lang}`);
    this.editor.setTheme(`ace/theme/${theme}`);

    this.editor.on("change", () => {
      this.beforeContent = this.editor.getValue();
      this.$emit("change-content", this.editor.getValue());
    });
  },

  watch: {
    content(value) {
      if (this.beforeContent !== value) {
        this.editor.setValue(value, 1);
      }
    }
  },
};
</script>
