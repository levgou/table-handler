<template>
  <span :class="pulseClass"></span>
</template>

<script>
export default {
  name: 'PulsingLight',   
  props: ['pulseClass'],
  data: ()=> ({

  }), 
}
</script>


<style scoped>
.pulse-green {
  display: block;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: #19883ec9;
  cursor: pointer;
  box-shadow: 0 0 0 rgba(67, 236, 52, 0.4);
  animation: pulse-green 2s infinite;
}
.pulse-green:hover {
  animation: none;
}

@-webkit-keyframes pulse-green {
  0% {
    -webkit-box-shadow: 0 0 0 0 rgba(67, 236, 52, 0.4);
  }
  70% {
    -webkit-box-shadow: 0 0 0 10px rgba(67, 236, 52, 0);
  }
  100% {
    -webkit-box-shadow: 0 0 0 0 rgba(67, 236, 52, 0.4);
  }
}
@keyframes pulse-green {
  0% {
    -moz-box-shadow: 0 0 0 0 rgba(67, 236, 52, 0.4);
    box-shadow: 0 0 0 0 rgba(67, 236, 52, 0.4);
  }
  70% {
    -moz-box-shadow: 0 0 0 10px rgba(67, 236, 52, 0);
    box-shadow: 0 0 0 10px rgba(67, 236, 52, 0);
  }
  100% {
    -moz-box-shadow: 0 0 0 0 rgba(67, 236, 52, 0);
    box-shadow: 0 0 0 0 rgba(67, 236, 52, 0);
  }
}

.pulse-red {
  display: block;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: #b81f0a99;
  cursor: pointer;
  box-shadow: 0 0 0 rgba(214, 76, 34, 0.4);
  animation: pulse-red 2s infinite;
}
.pulse-red:hover {
  animation: none;
}

@-webkit-keyframes pulse-red {
  0% {
    -webkit-box-shadow: 0 0 0 0 rgba(214, 76, 34, 0.4);
  }
  70% {
    -webkit-box-shadow: 0 0 0 10px rgba(214, 76, 34, 0);
  }
  100% {
    -webkit-box-shadow: 0 0 0 0 rgba(214, 76, 34, 0.4);
  }
}
@keyframes pulse-red {
  0% {
    -moz-box-shadow: 0 0 0 0 rgba(214, 76, 34, 0.4);
    box-shadow: 0 0 0 0 rgba(214, 76, 34, 0.4);
  }
  70% {
    -moz-box-shadow: 0 0 0 10px rgba(214, 76, 34, 0);
    box-shadow: 0 0 0 10px rgba(214, 76, 34, 0);
  }
  100% {
    -moz-box-shadow: 0 0 0 0 rgba(214, 76, 34, 0);
    box-shadow: 0 0 0 0 rgba(214, 76, 34, 0);
  }
}
</style>

