class DataEdit extends React.Component {
  setValues () {
  	document.getElementById("title").value = this.props.title;
  	document.getElementById("description").value = this.props.description;
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
				<label htmlFor="file">File To Upload:</label>
				<p>{this.props.url}</p>
				<br />
				<input type="submit" value="Submit Changes" />
			</form>
		</div>
   	);
  }
}

DataEdit.displayName = "DataEdit";
DataEdit.propTypes = {
	link_path: React.PropTypes.string.isRequired
};
