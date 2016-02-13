class DataShow extends React.Component {
  componentDidMount () {
  	var datum_audiences = $('.datum-audiences');
  	var audiences = this.props.audiences;
  	console.log(audiences);
  	for(var i = 0;i < audiences.length;i++){
  		var audience = audiences[i];
  		datum_audiences.append($('<p />').text(audience.name));
  	}
  }
  render () {
    return (
    	<div className="card-panel">
    		<h2>{this.props.datum.title}</h2>
	    	<div className="card-panel">
	    		Description:<br />{this.props.datum.description}
	    	</div>
	    	<DataViewer url={this.props.datum.url} data_id={this.props.datum.id} />
	    	<p><b>Audience</b></p>
        <a href={this.props.add_audience_path}>Add Audience</a>
	    	<div className="datum-audiences">
	    	</div>
    	</div>
	);
  }
}

DataShow.displayName = "DataShow";


