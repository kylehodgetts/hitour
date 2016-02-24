class DataViewer extends React.Component {
  checkIfVideo () {
    var videoExtensions = ["mp4","avi","mov","avchd","flv","mpg","mpeg-4","wmv"];
    for(var i = 0;i < videoExtensions.length;i++){
      if((this.props.url).toLowerCase().indexOf(videoExtensions[i]) > -1){
        console.log('Contains: '+videoExtensions[i]);
        return true;
      }
    }
    return false;
  }
  checkIfImage () {
    var imageExtensions = ["jpg","png","gif"];
    for(var i = 0;i < imageExtensions.length;i++){
      if((this.props.url).toLowerCase().indexOf(imageExtensions[i]) > -1){
        return true;
      }
    }
    return false;
  }

  componentDidMount () {
    var url = this.props.url;
    var datum_preview = $("."+this.props.data_id);
    if(this.checkIfImage()){
      console.log('Is an image');
      var img = $('<img />').attr('src',url).addClass("responsive-img");
      datum_preview.append(img);
    }else if(this.checkIfVideo()){
      console.log('Is an video');
        console.log('Adding video');
        var video = $('<video />').addClass("responsive-video");
        video.append($('<source />').attr('src',url));
        video.attr('controls','');
        video.attr('autoplay','');
        datum_preview.append(video);
    }else{
      var a = $('<a />').attr('href',url);
      a.text('Download File');
      datum_preview.append(a);
    }
  }
  render () {
    return (
      <div className={this.props.data_id+" center"}>

      </div>
    );
  }
};

DataViewer.displayName = "DataViewer";

