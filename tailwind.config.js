module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js'
  ],
  plugins: [
    require('flowbite/plugin')
  ],
  theme: {
    extend: {
      colors: {
        default: '#2e3746',
        sinaptia: {
          1: '#19FFE4',
          2: '#00B7A1',
          3: '#009E8C',
          4: '#EAB308',
          5: '#FACC15'
        }
      }
    }
  }
}
