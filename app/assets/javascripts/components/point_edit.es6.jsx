class PointEdit extends React.Component {
  componentDidMount (){
  	document.getElementById("name").value = this.props.point.name;
  }
  render () {
    return (
    	<div>
			<form id="uploadForm" encType="multipart/form-data" method="post" action={this.props.link_path}>
				<input type="hidden" name="_method" value="patch" />
				<label htmlFor="name">Point Name:</label>
				<input id="name" type="text" name="point[name]"/>
				<br />
				<input type="submit" value="Submit Changes" />
			</form>
		</div>
	);
  }
}

