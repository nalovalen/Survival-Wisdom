document.getElementById('background')
    .onmousemove = function(event) {
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
            } else if (x < 40) {  // Rango del 25% al 40% (más pequeño a la izquierda)
                x = (x - 55) / degree;
                div.style.transform = "translateY(" + y + "%) rotate(" + parseInt(x) + "deg)";
                document.getElementById('optionleft').style.opacity = "1";
            } else {
                div.style.transform = "translateY(0%) rotate(0deg)";
                document.getElementById('optionleft').style.opacity = "0";
                document.getElementById('optionright').style.opacity = "0";
            }
        } else {
            // Si está fuera del rango 25%-75%, restablece la carta
            div.style.transform = "translateY(0%) rotate(0deg)";
            document.getElementById('optionleft').style.opacity = "0";
            document.getElementById('optionright').style.opacity = "0";
        }
    };

document.getElementById('background').onmouseleave = function(event) {
    var div = document.getElementById('carddiv');
    div.style.transform = "translateY(0%) rotate(0deg)";
    document.getElementById('optionright').style.opacity = "0";
    document.getElementById('optionleft').style.opacity = "0";
};

document.addEventListener('click', function(event) {
    var bg = document.getElementById('background');
    var x = event.clientX / bg.clientWidth * 100;

    // Solo responde a clics entre 25% y 75%
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

