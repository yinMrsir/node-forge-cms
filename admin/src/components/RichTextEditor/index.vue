<template>
  <div style="border: 1px solid #ccc">
    <Toolbar :editor="editorRef" :defaultConfig="toolbarConfig" style="border-bottom: 1px solid #ccc" />
    <Editor
      v-model="valueHtml"
      :defaultConfig="editorConfig"
      style="height: 500px; overflow-y: hidden"
      @onCreated="handleCreated"
    />
  </div>
</template>
<script setup>
  import '@wangeditor-next/editor/dist/css/style.css';
  import { onBeforeUnmount, ref, shallowRef, onMounted } from 'vue';
  import { Editor, Toolbar } from '@wangeditor/editor-for-vue';
  import { ElMessage } from 'element-plus';

  const props = defineProps({
    modelValue: {
      type: String,
      default: ''
    }
  });

  const emit = defineEmits();
  const editorRef = shallowRef();
  const valueHtml = computed({
    get() {
      return String(props.modelValue);
    },
    set(value) {
      emit('update:modelValue', value);
    }
  });

  const editorConfig = {
    placeholder: '请输入内容...',
    MENU_CONF: {
      uploadImage: {
        server: import.meta.env.VITE_APP_BASE_API + `/common/upload`, // 服务端地址
        fieldName: 'file',
        maxFileSize: 10 * 1024 * 1024, // 1M
        allowedFileTypes: ['image/*'],
        // 自定义插入返回格式【后端返回的格式】
        customInsert(res, insertFn) {
          if (res.code != 200) {
            ElMessage.error('上传文件失败，' + res.message);
            return;
          }
          insertFn(res.data.url, '', res.data.url);
        },
        onSuccess(file, res) {
          ElMessage.success(`${file.name} 上传成功`);
        },
        onFailed(file, res) {
          ElMessage.error(`${file.name} 上传失败`);
        },
        onError(file, err, res) {
          ElMessage.error(`${file.name} 上传出错`);
        }
      }
    }
  };
  const toolbarConfig = {};
  const handleCreated = editor => {
    editorRef.value = editor; // 记录 editor 实例，重要！
  };

  onBeforeUnmount(() => {
    const editor = editorRef.value;
    if (editor == null) return;
    editor.destroy();
  });
</script>
