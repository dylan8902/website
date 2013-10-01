require 'coderay'
class VideoController < ApplicationController

  # GET /video
  def index
    html_block = <<-EOS
<video id="video" style="display:none;" autoplay></video>
<canvas id="canvas" width="375" height="300"></canvas>

<script type="text/javascript">
  var video = document.getElementById('video');
  var canvas = document.getElementById('canvas');
  var ctx = canvas.getContext('2d');
  
  if (navigator.webkitGetUserMedia) {
    navigator.webkitGetUserMedia(
      {"audio": true, "video": true},
      function (stream) {
        video.src = webkitURL.createObjectURL(stream);
        video.onerror = function () {
          stream.stop();
          alert('Error!');
        };
        var loadImage = window.setInterval(function() {
        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
      }, 50);
    }, function () {
      alert('No camera');
    });
  }
  else {
    alert('Not supported!');
  }
</script>
EOS

    @h = CodeRay.scan(html_block, :html).div.html_safe
  end

end
