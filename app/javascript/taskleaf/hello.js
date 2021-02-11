import React, { createElement } from 'react'
import ReactDOM from 'react-dom'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    createElement('div', null, 'Hello world!!'),
    document.getElementById('app'),
  )
})