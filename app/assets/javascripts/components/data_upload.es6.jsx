class DataUpload extends React.Component {
  render () {
    return (
		<div>
			<form id="uploadForm" encType="multipart/form-data" method="post" action={this.props.link_path}>
				<label htmlFor="title">Title:</label>
				<input id="title" type="text" name="title" />
				<br />
				<label htmlFor="description">Description:</label>
				<input type="text" id="description" name="description" />
				<br />
				<label htmlFor="file">File To Upload:</label>
				<input type="file" id="file" name="file"/>
				<br />
				<input type="submit" value="Upload Data" />
			</form>
		</div>
   	);
  }
}

DataUpload.displayName = "DataUpload";
DataUpload.propTypes = {
	link_path: React.PropTypes.string.isRequired
};
