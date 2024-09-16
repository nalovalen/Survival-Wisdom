document.addEventListener('DOMContentLoaded', function() {
    var comodinElement = document.getElementById('comodin-data');
    var comodin = parseInt(comodinElement.getAttribute('data-comodin'), 10);
    var modal = document.getElementById('warningModal');

    // Función para verificar si el modal está visible
    function isModalVisible() {
        return modal.style.display === 'flex';
    }

    document.getElementById('background').onmousemove = function(event) {
        if (isModalVisible()) {
            return; // No hacer nada si el modal está visible
        }
        var bg = document.getElementById('background');
        var x = event.clientX / bg.clientWidth * 100; // Obtén la posición del mouse en porcentaje
        var y = event.clientY / bg.clientHeight * 100;
        y = y / 25;

        var degree = 4.3;
        var div = document.getElementById('carddiv');

        // Solo responde a movimientos entre 25% y 75%
        if (x >= 25 && x <= 75) {
            if (x > 60) {  // Rango del 60% al 75% (más amplio a la derecha)
                x = (x - 55) / degree;
                div.style.transform = "translateY(" + y + "%) rotate(" + parseInt(x) + "deg)";
                document.getElementById('optionright').style.opacity = "1";
                if (comodin === 3) {
                    showEffects('right');
                }
            } else if (x < 40) {  // Rango del 25% al 40% (más pequeño a la izquierda)
                x = (x - 55) / degree;
                div.style.transform = "translateY(" + y + "%) rotate(" + parseInt(x) + "deg)";
                document.getElementById('optionleft').style.opacity = "1";
                if (comodin === 3) {
                    showEffects('left');
                }
            } else {
                div.style.transform = "translateY(0%) rotate(0deg)";
                document.getElementById('optionleft').style.opacity = "0";
                document.getElementById('optionright').style.opacity = "0";
                hideEffects();
            }
        } else {
            // Si está fuera del rango 25%-75%, restablece la carta
            div.style.transform = "translateY(0%) rotate(0deg)";
            document.getElementById('optionleft').style.opacity = "0";
            document.getElementById('optionright').style.opacity = "0";
            hideEffects();
        }
    };

    document.getElementById('background').onmouseleave = function(event) {
        if (isModalVisible()) {
            return; // Salir si el modal está activo
        }
        var div = document.getElementById('carddiv');
        div.style.transform = "translateY(0%) rotate(0deg)";
        document.getElementById('optionright').style.opacity = "0";
        document.getElementById('optionleft').style.opacity = "0";
        hideEffects(); // Asegurar que se ocultan los efectos al salir del área
    };

    // Función para mostrar los efectos basados en la posición del mouse
    function showEffects(position) {
        var effectsElement = document.getElementById('effects-data');
        var comodinElement = document.getElementById('comodin-data');
        
        // Verificar si el modal está visible
        if (isModalVisible()) {
            return;
        }

        // Definir los efectos basados en la posición (izquierda o derecha)
        var effects = {
            'left': {
                health: parseInt(effectsElement.getAttribute('data-left-health'), 10),
                hunger: parseInt(effectsElement.getAttribute('data-left-hunger'), 10),
                water: parseInt(effectsElement.getAttribute('data-left-water'), 10),
                temperature: parseInt(effectsElement.getAttribute('data-left-temperature'), 10)
            },
            'right': {
                health: parseInt(effectsElement.getAttribute('data-right-health'), 10),
                hunger: parseInt(effectsElement.getAttribute('data-right-hunger'), 10),
                water: parseInt(effectsElement.getAttribute('data-right-water'), 10),
                temperature: parseInt(effectsElement.getAttribute('data-right-temperature'), 10)
            }
        };

        var effectsToShow = effects[position] || {};

        // Actualizar el contenido de los efectos
        document.getElementById('health-effect').textContent = `Health: ${effectsToShow.health || 0}`;
        document.getElementById('hunger-effect').textContent = `Hunger: ${effectsToShow.hunger || 0}`;
        document.getElementById('water-effect').textContent = `Water: ${effectsToShow.water || 0}`;
        document.getElementById('temperature-effect').textContent = `Temperature: ${effectsToShow.temperature || 0}`;
    
    }
    
    // Event listener para el movimiento del mouse
    document.addEventListener('mousemove', function(event) {
        var position = event.clientX < window.innerWidth / 2 ? 'left' : 'right';
        showEffects(position);
    });

    // Función para ocultar los efectos
    function hideEffects() {
        document.querySelectorAll('.effect').forEach(function(element) {
            element.style.display = 'none'; // Ocultar los efectos
        });
    }

    // Bloquear clics en el fondo si el modal está visible
    document.addEventListener('click', function(event) {
        if (isModalVisible()) {
            return; // No responder a clics si el modal está activo
        }
        var bg = document.getElementById('background');
        var x = event.clientX / bg.clientWidth * 100;

        if (x >= 25 && x <= 75) {
            if (x < 40) {  // Rango del 25% al 40% (más pequeño a la izquierda)
                enviarValor(1);
            } else if (x > 60) {  // Rango del 60% al 75% (más amplio a la derecha)
                enviarValor(2);
            }
        }
    });

    function enviarValor(valor) {
        document.getElementById('valorInput').value = valor;
        document.getElementById('myForm').submit();
    }

    function handleClick(buttonNumber) {
        let coinBlock = document.getElementById("coin-block");
        let remainingCoins = parseInt(coinBlock.textContent) - buttonNumber;
        coinBlock.textContent = remainingCoins > 0 ? remainingCoins : 0;
    }
});
