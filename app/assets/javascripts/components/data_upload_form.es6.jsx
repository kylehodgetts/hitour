var DataUpload = React.createClass({
	displayName: "DataUpload",
	render: function() {
		return (
			<div>
				<form id="uploadForm" encType="multipart/form-data" method="post" action="https://localhost:3000/data">
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
});

