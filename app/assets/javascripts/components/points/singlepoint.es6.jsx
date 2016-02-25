class SinglePoint extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      point: [],
      point_data: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
    // var postUrl = this.props.new_point_datum_url;
    // $('#tourPointForm').on('submit',function(e){
    //   e.preventDefault();
    //   $.ajax({
    //     url: postUrl,
    //     type: "POST",
    //     data: $(this).serialize(),
    //     dataType: "json",
    //     success: function(data){
    //       Materialize.toast(data, 3000, 'rounded');
    //     }.bind(this),
    //     error: function(err){
    //       Materialize.toast('There was an issue adding the point. Please contact admin.', 3000, 'rounded');
    //       console.log(err);
    //     }.bind(this)
    //   });
    // });
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  handleLoadDataFromServer() {
    //Get All Point and Data
    console.log("Requesting: "+this.props.getUrl);
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        $('select').material_select();
        console.log(data);
        this.setState({
          point: data["point"],
          point_data: data["point_data"]
        });
      }.bind(this)
    });
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className="col s6">
          </div>
          <div className="col s6">
            <h2>{this.state.point.name}</h2>
          </div>
        </div>
        <div className="row">
          <ul className="collapsible" data-collapsible="accordion">
            {this.state.point_data.map(function(point_data) {
            return (
              <li key={point_data.id}>
                <div className="collapsible-header">
                  {point_data.rank+". "+point_data.title}
                </div>
                <div className="collapsible-body">
                    <p>{point_data.description}</p>
                   <DataViewer url={point_data.url} data_id={point_data.id} />
                </div>
              </li>
            );
          }, this)}
          </ul>
        </div>
      </div>
    );
  }
}
SinglePoint.displayName = "SinglePoint";
SinglePoint.propTypes = {
  qrCode: React.PropTypes.any,
  getUrl: React.PropTypes.string.isRequired,
  new_point_datum_url: React.PropTypes.string.isRequired
}
