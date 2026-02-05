<template>
  <div class="welcome">
    <h1>欢迎使用NodeForgeCMS!</h1>
    <img src="/welcome.png" alt="" />、
  </div>
</template>

<style lang="scss" scoped>
  .welcome {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    height: calc(100vh - 84px);
    h1 {
      margin-bottom: 20px;
      font-size: 28px;
      color: #91addc;
    }
  }
</style>

<script setup>
  const version = ref('0.0.1');

  function goTarget(url) {
    window.open(url, '__blank');
  }
</script>
