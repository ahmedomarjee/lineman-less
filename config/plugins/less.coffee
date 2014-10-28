module.exports = (lineman) ->
  app = lineman.config.application

  files:
    less:
      main: "src/css/main.less"
      app: "src/css/**/*.less"
      vendor: "vendor/css/**/*.less"
      generatedApp: "generated/css/app.less.css"
      generatedVendor: "generated/css/vendor.less.css"

  config:
    loadNpmTasks: app.loadNpmTasks.concat('grunt-contrib-less')

    prependTasks:
      common: app.prependTasks.common.concat("less")

    less:
      options:
        paths: ["src/css", "vendor/css"]
      compile:
        files:
          "<%= files.less.generatedApp %>": ["<%= files.less.main %>", "<%= files.less.app %>"]
          "<%= files.less.generatedVendor %>": ["<%= files.less.vendor %>"]

    concat_sourcemap:
      css:
        src: app.concat_sourcemap.css.src.concat("<%= files.less.generatedApp %>", "<%= files.less.generatedVendor %>")

    watch:
      less:
        files: ["<%= files.less.main %>", "<%= files.less.app %>", "<%= files.less.vendor %>"]
        tasks: ["less", "concat_sourcemap:css"]