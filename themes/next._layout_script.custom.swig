{%
  set custom_scripts = [
    'src/love.js',
    'src/particle.js'
  ]
%}

{% for cs in custom_scripts %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ cs }}?v={{ theme.version }}"></script>
{% endfor %}
