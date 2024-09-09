document.addEventListener('DOMContentLoaded', function() {
    const nicknameButton = document.getElementById('nickname-btn');
    const nicknameForm = document.getElementById('nickname-form');
    
    const passwordButton = document.getElementById('password-btn');
    const passwordForm = document.getElementById('password-form');

    nicknameButton.addEventListener('click', function() {
        passwordForm.classList.add('hidden-input'); // Oculta el otro formulario
        nicknameForm.classList.toggle('hidden-input'); // Muestra el formulario de nickname
    });

    passwordButton.addEventListener('click', function() {
        nicknameForm.classList.add('hidden-input'); // Oculta el otro formulario
        passwordForm.classList.toggle('hidden-input'); // Muestra el formulario de password
    });
});