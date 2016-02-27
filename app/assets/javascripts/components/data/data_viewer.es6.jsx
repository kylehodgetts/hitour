class DataViewer extends React.Component {
  checkIfVideo () {
    var videoExtensions = ["mp4","avi","mov","avchd","flv","mpg","mpeg-4","wmv"];
    for(var i = 0;i < videoExtensions.length;i++){
      if((this.props.url).toLowerCase().indexOf(videoExtensions[i]) > -1){
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
    var placeHolder = "/assets/placeHolderImage.png";
    var placeHolderImage = $('<img />').attr('src',placeHolder).addClass("responsive-img");
    placeHolderImage.attr('height','300px;');
    if(this.props.url == undefined){
      datum_preview.append(img);
      return;
    }
    if(this.checkIfImage()){
      var img = $('<img />').attr('src',url).addClass("responsive-img");
      datum_preview.append(img);
    }else if(this.checkIfVideo()){
        var video = $('<video />').addClass("responsive-video");
        video.append($('<source />').attr('src',url));
        video.attr('controls','');
        datum_preview.append(video);
    }else{
      var a = $('<a />').attr('href',url);
      a.append(placeHolderImage);
      a.attr('download','');
      // a.text('Download File');
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
