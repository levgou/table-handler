<template>
  <div>
    <div id="container">
      <p :class="shta_style">
        <a>S H T A</a>
      </p>
    </div>

    <!-- "http://www.f-rilling.com/projects/" -->

    <div class="text-xs-center">
      <v-btn fab dark small color="#ff117770" @click="shta_style='numbah1'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>

      <v-btn fab dark small color="#228dff70" @click="shta_style='numbah2'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>

      <v-btn fab dark small color="#ffdd1b70" @click="shta_style='numbah3'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>

      <v-btn fab dark small color="#b6ff0070" @click="shta_style='numbah4'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>

      <v-btn fab dark small color="#ff990070" @click="shta_style='numbah5'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>

      <v-btn fab dark small color="#ba01ff70" @click="shta_style='numbah6'">
        <v-icon dark>brightness_1</v-icon>
      </v-btn>
    </div>
  </div>
</template>

<script>
export default {
    data: () => ({
        shta_style: "numbah1",
    })
}
</script>


<style scoped>
@import url("https://fonts.googleapis.com/css?family=Monoton");
@import url("https://fonts.googleapis.com/css?family=Iceland");
@import url("https://fonts.googleapis.com/css?family=Pacifico");
@import url("https://fonts.googleapis.com/css?family=Press+Start+2P");
@import url("https://fonts.googleapis.com/css?family=Audiowide");
@import url("https://fonts.googleapis.com/css?family=Vampiro+One");

body {
  background-color: #222222;
  background: repeating-linear-gradient(
      45deg,
      #2b2b2b 0%,
      #2b2b2b 10%,
      #222222 0%,
      #222222 50%
    )
    0 / 15px 15px;
}

#container {
  width: 800px;
  margin: auto;
}

/*Neon*/
p {
  text-align: center;
  font-size: 10em;
  margin: 250px 0 100px 0;
}

a {
  text-decoration: none;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
  transition: all 0.5s;
}

p.numbah1 a {
  color: #fff;
  font-family: Monoton;
  -webkit-animation: neon1 1.5s ease-in-out infinite alternate;
  -moz-animation: neon1 1.5s ease-in-out infinite alternate;
  animation: neon1 1.5s ease-in-out infinite alternate;
}

p.numbah1 a:hover {
  color: #ff1177;
  -webkit-animation: none;
  -moz-animation: none;
  animation: none;
}

p.numbah2 a {
  font-size: 1.5em;
  color: #228dff;
  font-family: Iceland;
}

p.numbah2 a:hover {
  -webkit-animation: neon2 1.5s ease-in-out infinite alternate;
  -moz-animation: neon2 1.5s ease-in-out infinite alternate;
  animation: neon2 1.5s ease-in-out infinite alternate;
}

p.numbah3 a {
  color: #ffdd1b;
  font-family: Pacifico;
}

p.numbah3 a:hover {
  -webkit-animation: neon3 1.5s ease-in-out infinite alternate;
  -moz-animation: neon3 1.5s ease-in-out infinite alternate;
  animation: neon3 1.5s ease-in-out infinite alternate;
}

p.numbah4 a {
  color: #b6ff00;
  font-family: "Press Start 2P";
  font-size: 0.8em;
}

p.numbah4 a:hover {
  -webkit-animation: neon4 1.5s ease-in-out infinite alternate;
  -moz-animation: neon4 1.5s ease-in-out infinite alternate;
  animation: neon4 1.5s ease-in-out infinite alternate;
}

p.numbah5 a {
  color: #ff9900;
  font-family: Audiowide;
}

p.numbah5 a:hover {
  -webkit-animation: neon5 1.5s ease-in-out infinite alternate;
  -moz-animation: neon5 1.5s ease-in-out infinite alternate;
  animation: neon5 1.5s ease-in-out infinite alternate;
}

p.numbah6 a {
  color: #ba01ff;
  font-family: Vampiro One;
}

p.numbah6 a:hover {
  -webkit-animation: neon6 1.5s ease-in-out infinite alternate;
  -moz-animation: neon6 1.5s ease-in-out infinite alternate;
  animation: neon6 1.5s ease-in-out infinite alternate;
}

p :hover {
  color: #ffffff;
}
/*glow for webkit*/

@-webkit-keyframes neon1 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff1177,
      0 0 70px #ff1177, 0 0 80px #ff1177, 0 0 100px #ff1177, 0 0 150px #ff1177;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff1177,
      0 0 35px #ff1177, 0 0 40px #ff1177, 0 0 50px #ff1177, 0 0 75px #ff1177;
  }
}

@-webkit-keyframes neon2 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #228dff,
      0 0 70px #228dff, 0 0 80px #228dff, 0 0 100px #228dff, 0 0 150px #228dff;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #228dff,
      0 0 35px #228dff, 0 0 40px #228dff, 0 0 50px #228dff, 0 0 75px #228dff;
  }
}

@-webkit-keyframes neon3 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ffdd1b,
      0 0 70px #ffdd1b, 0 0 80px #ffdd1b, 0 0 100px #ffdd1b, 0 0 150px #ffdd1b;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ffdd1b,
      0 0 35px #ffdd1b, 0 0 40px #ffdd1b, 0 0 50px #ffdd1b, 0 0 75px #ffdd1b;
  }
}

@-webkit-keyframes neon4 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #b6ff00,
      0 0 70px #b6ff00, 0 0 80px #b6ff00, 0 0 100px #b6ff00, 0 0 150px #b6ff00;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #b6ff00,
      0 0 35px #b6ff00, 0 0 40px #b6ff00, 0 0 50px #b6ff00, 0 0 75px #b6ff00;
  }
}

@-webkit-keyframes neon5 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff9900,
      0 0 70px #ff9900, 0 0 80px #ff9900, 0 0 100px #ff9900, 0 0 150px #ff9900;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff9900,
      0 0 35px #ff9900, 0 0 40px #ff9900, 0 0 50px #ff9900, 0 0 75px #ff9900;
  }
}

@-webkit-keyframes neon6 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de,
      0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff00de,
      0 0 35px #ff00de, 0 0 40px #ff00de, 0 0 50px #ff00de, 0 0 75px #ff00de;
  }
}
/*glow for mozilla*/

@-moz-keyframes neon1 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff1177,
      0 0 70px #ff1177, 0 0 80px #ff1177, 0 0 100px #ff1177, 0 0 150px #ff1177;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff1177,
      0 0 35px #ff1177, 0 0 40px #ff1177, 0 0 50px #ff1177, 0 0 75px #ff1177;
  }
}

@-moz-keyframes neon2 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #228dff,
      0 0 70px #228dff, 0 0 80px #228dff, 0 0 100px #228dff, 0 0 150px #228dff;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #228dff,
      0 0 35px #228dff, 0 0 40px #228dff, 0 0 50px #228dff, 0 0 75px #228dff;
  }
}

@-moz-keyframes neon3 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ffdd1b,
      0 0 70px #ffdd1b, 0 0 80px #ffdd1b, 0 0 100px #ffdd1b, 0 0 150px #ffdd1b;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ffdd1b,
      0 0 35px #ffdd1b, 0 0 40px #ffdd1b, 0 0 50px #ffdd1b, 0 0 75px #ffdd1b;
  }
}

@-moz-keyframes neon4 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #b6ff00,
      0 0 70px #b6ff00, 0 0 80px #b6ff00, 0 0 100px #b6ff00, 0 0 150px #b6ff00;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #b6ff00,
      0 0 35px #b6ff00, 0 0 40px #b6ff00, 0 0 50px #b6ff00, 0 0 75px #b6ff00;
  }
}

@-moz-keyframes neon5 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff9900,
      0 0 70px #ff9900, 0 0 80px #ff9900, 0 0 100px #ff9900, 0 0 150px #ff9900;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff9900,
      0 0 35px #ff9900, 0 0 40px #ff9900, 0 0 50px #ff9900, 0 0 75px #ff9900;
  }
}

@-moz-keyframes neon6 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de,
      0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff00de,
      0 0 35px #ff00de, 0 0 40px #ff00de, 0 0 50px #ff00de, 0 0 75px #ff00de;
  }
}
/*glow*/

@keyframes neon1 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff1177,
      0 0 70px #ff1177, 0 0 80px #ff1177, 0 0 100px #ff1177, 0 0 150px #ff1177;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff1177,
      0 0 35px #ff1177, 0 0 40px #ff1177, 0 0 50px #ff1177, 0 0 75px #ff1177;
  }
}

@keyframes neon2 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #228dff,
      0 0 70px #228dff, 0 0 80px #228dff, 0 0 100px #228dff, 0 0 150px #228dff;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #228dff,
      0 0 35px #228dff, 0 0 40px #228dff, 0 0 50px #228dff, 0 0 75px #228dff;
  }
}

@keyframes neon3 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ffdd1b,
      0 0 70px #ffdd1b, 0 0 80px #ffdd1b, 0 0 100px #ffdd1b, 0 0 150px #ffdd1b;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ffdd1b,
      0 0 35px #ffdd1b, 0 0 40px #ffdd1b, 0 0 50px #ffdd1b, 0 0 75px #ffdd1b;
  }
}

@keyframes neon4 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #b6ff00,
      0 0 70px #b6ff00, 0 0 80px #b6ff00, 0 0 100px #b6ff00, 0 0 150px #b6ff00;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #b6ff00,
      0 0 35px #b6ff00, 0 0 40px #b6ff00, 0 0 50px #b6ff00, 0 0 75px #b6ff00;
  }
}

@keyframes neon5 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff9900,
      0 0 70px #ff9900, 0 0 80px #ff9900, 0 0 100px #ff9900, 0 0 150px #ff9900;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff9900,
      0 0 35px #ff9900, 0 0 40px #ff9900, 0 0 50px #ff9900, 0 0 75px #ff9900;
  }
}

@keyframes neon6 {
  from {
    text-shadow: 0 0 10px #fff, 0 0 20px #fff, 0 0 30px #fff, 0 0 40px #ff00de,
      0 0 70px #ff00de, 0 0 80px #ff00de, 0 0 100px #ff00de, 0 0 150px #ff00de;
  }
  to {
    text-shadow: 0 0 5px #fff, 0 0 10px #fff, 0 0 15px #fff, 0 0 20px #ff00de,
      0 0 35px #ff00de, 0 0 40px #ff00de, 0 0 50px #ff00de, 0 0 75px #ff00de;
  }
}
/*REEEEEEEEEEESPONSIVE*/

@media (max-width: 1050px) {
  #container {
    width: 100%;
  }
  /* p {
    font-size: 50px;
  } */
}
</style>

