<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <link href="docs/css/main.css" rel="stylesheet">

  <script>
function move() {
  var elem = document.getElementById("myBar");
  var width = 10;
  var id = setInterval(frame, 100);
  function frame() {
    if (width >= 100) {
      clearInterval(id);
    } else {
      width++;
      elem.style.width = width + '%';
      document.getElementById("label").innerHTML = width * 1  + '%';
    }
  }
}

$(document).ready(function(){
    $(".btn").click(function(){
        $(this).button('').queue(function(){


        });
    });
});

</script>

 <script>
function moveStop() {
  var elem = document.getElementById("myBar");
  $stop.on("click", function() {
        var $bar = $("myBar");
        $elem.stop();
    }
  }
}
</script>



  </style>
</head>

<body>
<div class="jumbotron text-center">
  <h1>Pagina de Riego</h1>
  <p>Nueva Pagina de riego con mejor funcionalidad</p>
</div>
<div class="container">
  <div class="row">
    <div class="col-sm-4">
      <div class="container">
          <!--GPIO17-->
             <div>


              GPIO 17&nbsp; <input action="" onclick method="post" type="submit" onclick="move()" class="btn btn-info" name="encendido17" value="Activar Riego Corto">

                 <button onclick="moveStop()"class="btn btn-info" name="apagado17">Desactivar Riego Corto</button>
                 </div>
                    <br></br>
                    <button onclick="move2()"class="btn btn-success">Activar Riego Largo</button>
                     </div>
    <div class="col-sm-4">
      <h3>Riego Corto</h3>
      <p>El riego corto dura 3 minutos aproximadamente</p>
      <p>Recomendado para invierno</p>
    </div>
    <div class="col-sm-4">
      <h3>Riego Largo</h3>
      <p>El riego largo dura 10 minutos aproximadamente</p>
      <p>Recomendado para verano y dias calurosos</p>
    </div>
  </div>
</div>
<div id="myProgress">
  <div id="myBar">
    <div id="label">10%</div>
  </div>
</div>
<div>
<br></br>

  <!--GPIO17-->
  <form action="" method="post">
   GPIO 17&nbsp;<input type="submit" class="btn btn-success"  value="Encender">
   <input type="submit" class="btn btn-success" value="Apagar" name="encendido">

 <br></br>

  <!--GPIO27-->
  <form action="" method="post">
   GPIO 27&nbsp;<input type="submit" name="encender27" value="Encender">
   <input type="submit" name="apagar27" value="Apagar">
   <input type="submit" name="parpadear27" value="Parpadear">

 <br></br>

  <!--GPIO4-->
  <form action="" method="post">
   GPIO 04&nbsp;<input type="submit" name="encender4" value="Encender">
   <input type="submit" name="apagar4" value="Apagar">
   <input type="submit" name="parpadear4" value="Parpadear">

 <br></br>

  <!--GPIO22-->
  <form action="" method="post">
   GPIO 22&nbsp;<input type="submit" name="encender22" value="Encender">
   <input type="submit" name="apagar22" value="Apagar">
   <input type="submit" name="parpadear22" value="Parpadear">

</div>




</body>
</html>
