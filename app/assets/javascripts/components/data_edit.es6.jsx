class DataEdit extends React.Component {
  checkIfVideo () {
  	var videoExtensions = ["mp4","avi","mov","avchd","flv","mpg","mpeg-4","wmv"];
    return $.inArray(this.props.url,videoExtensions);
  }
  checkIfImage () {
  	var imageExtensions = ["jpg","png","gif"];
    return $.inArray(this.props.url,imageExtensions);
  }

  setValues () {
  	document.getElementById("title").value = this.props.title;
  	document.getElementById("description").value = this.props.description;

  	//Check if video of photo
  	var file_preview = $('.file-preview');
  	var url = this.props.url;
	
	if(this.checkIfImage()){
		console.log('Is an image');
  		var img = $('<img />').attr('src',url);
  		file_preview.append(img);
	}else if(this.checkIfVideo()){
		console.log('Is an video');
  		console.log('Adding video');
  		var video = $('<video />').attr('src',url);
  		video.attr('controls','');
  		video.attr('autoplay','');
  		file_preview.append(video);
	}else{
		var a = $('<a />').attr('href',url);
		a.text('Download File');
		file_preview.append(a);
	}

  }
  
  componentDidMount (){
  	this.setValues();
  }
  render () {
    return (
		<div>
			<form id="uploadForm" encType="multipart/form-data" method="post" action={this.props.link_path}>
				<input type="hidden" name="_method" value="patch" />
				<label htmlFor="title">Title:</label>
				<input id="title" type="text" name="title"/>
				<br />
				<label htmlFor="description">Description:</label>
				<input type="text" id="description" name="description"/>
				<br />
				<label htmlFor="file">Current File:</label>
				<p>{this.props.url}</p>
				<br />
				<input type="submit" value="Submit Changes" />
			</form>
			<div className="file-preview"></div>
		</div>
   	);
  }
}

DataEdit.displayName = "DataEdit";
DataEdit.propTypes = {
	link_path: React.PropTypes.string.isRequired
};
