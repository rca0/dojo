'use strict'

const KEY_CODE_ENTER = 13
let input = document.getElementById('msg')
let messages = document.getElementById('messages')
let username = document.getElementById('username')
let userForm = document.getElementById('user-form')
let chatWindow = document.getElementById('chat-window')

let connection = new WebSocket('ws://localhost:9000');

function sendMsg() {
  connection.send(input.value)
  input.value = ''
}

connection.onopen = function () {
  console.log('open');
};

connection.onerror = function (error) {
  console.log('WebSocket Error ' + error);
};

connection.onmessage = function (e) {
  let data = JSON.parse(e.data)

  messages.innerHTML += `<br> ${data.user}: ${data.msg}`
};

input.addEventListener('keyup', function(e) {
  if (e.keyCode === KEY_CODE_ENTER) {
    sendMsg()
  }
})

username.addEventListener('keyup', function(e) {
  if (e.keyCode === KEY_CODE_ENTER) {
    chatWindow.classList.remove('hidden')
    userForm.classList.add('hidden')
    connection.send(username.value)
  }
})
