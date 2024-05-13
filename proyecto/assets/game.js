document.getElementById('background')
	.onmousemove = function(event) {
		var bg = document.getElementById('background');
		var windowWidth=90;
		var windowHeight=45;
		var x=event.clientX/bg.clientWidth*100;
		var y=event.clientY/bg.clientHeight*100;
		y=y/25;

		var degree = 4.3;
		var div=document.getElementById('carddiv');

		if(x>60){
			x= (x-55)/degree;
			div.style.transform= "translateY(" + y + "%) rotate(" + parseInt(x) + "deg)";
			document.getElementById('optionright').style.opacity="1";
		}
		else if(x<40){
			x= (x-45)/degree;
			div.style.transform= "translateY(" + y + "%) rotate(" + parseInt(x) + "deg)";
			document.getElementById('optionleft').style.opacity="1";
		}
		else{
			div.style.transform= "translateY(0%) rotate(0deg)";
			document.getElementById('optionleft').style.opacity="0";
			document.getElementById('optionright').style.opacity="0";
		}
	}

	document.getElementById('background').onmouseleave = function (event) {
		var div=document.getElementById('carddiv');
		div.style.transform= "translateY(0%) rotate(0deg)";
		document.getElementById('optionright').style.opacity="0";
		document.getElementById('optionleft').style.opacity="0";
	}


    document.addEventListener('click', function(event) {
        var bg = document.getElementById('background');
        var windowWidth = 90;
        var x = event.clientX / bg.clientWidth * 100;
    
        // Si la carta está inclinada hacia la izquierda
        if (x < 40) {
            // Aquí puedes hacer lo que necesites cuando se hace clic y la carta está inclinada hacia la izquierda
           
            // Por ejemplo, puedes enviar el valor 1
            enviarValor(1);
        }
        // Si la carta está inclinada hacia la derecha
        else if (x > 60) {
            // Aquí puedes hacer lo que necesites cuando se hace clic y la carta está inclinada hacia la derecha
            
            // Por ejemplo, puedes enviar el valor 2
            enviarValor(2);
        }
    });
    
    function enviarValor(valor) {
        // Aquí puedes hacer lo que necesites con el valor antes de enviarlo al servidor
        
        // Por ejemplo, puedes asignarlo a un campo oculto en un formulario
        document.getElementById('valorInput').value = valor;
        
        // Luego, puedes enviar el formulario
        document.getElementById('myForm').submit();
    }
    