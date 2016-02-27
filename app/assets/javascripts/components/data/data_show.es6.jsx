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
      <div className="row">
        <div className="col s10 m8 offset-s1 offset-m2">
          <div className="card hoverable">
            <div className="card-image">
              <DataViewer url={this.props.datum.url} data_id={this.props.datum.id} />
            </div>
            <div className="card-content">
              <span className="card-title activator grey-text text-darken-4">{this.props.datum.title}<i className="material-icons right">more_vert</i></span>
              <p>{this.props.datum.description}</p>
            </div>
            <div className="card-action">
              <a href="#">Delete Datum</a>
            </div>
            <div className="card-reveal">
              <span className="card-title grey-text text-darken-4">Audiences<i className="material-icons right">close</i></span>
              <div className="datum-audiences">
              </div>
            </div>
          </div>
        </div>
      </div>

	);
  }
}

DataShow.displayName = "DataShow";


