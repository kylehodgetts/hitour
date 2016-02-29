class DataViewer extends React.Component {
  componentDidMount () {
    var url = this.props.url;
    var datumPreview = $("."+this.props.data_id);
    var placeHolder = "/assets/placeHolderImage.png";
    var placeHolderImage = $('<img />').attr('src',placeHolder).addClass("responsive-img");
    placeHolderImage.attr('height','300px;');
    if(this.props.url == undefined){
      datumPreview.append(img);
      return;
    }
    if(this.checkIfImage()){
      var img = $('<img />').attr('src',url).addClass("responsive-img");
      datumPreview.append(img);
    }else if(this.checkIfVideo()){
      var video = $('<video />').addClass("responsive-video");
      video.append($('<source />').attr('src',url));
      video.attr('controls','');
      datumPreview.append(video);
    }else{
      var a = $('<a />').attr('href',url);
      a.append(placeHolderImage);
      a.attr('download','');
      // a.text('Download File');
      datumPreview.append(a);
    }
  }
  render () {
    return (
      <div className={this.props.data_id+" center"}>

      </div>
    );
  }
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
};

DataViewer.displayName = "DataViewer";
DataViewer.propTypes = {
  url: React.PropTypes.string.isRequired,
  data_id: React.PropTypes.number.isRequired
};
