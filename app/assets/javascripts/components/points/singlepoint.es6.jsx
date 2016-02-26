class SinglePoint extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      point: [],
      pointData: [],
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
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handleLoadDataFromServer() {
    //Get All Point and Data
    // console.log("Requesting: "+this.props.getUrl);
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        $('select').material_select();
        // console.log(data);
        this.setState({
          point: data.point,
          pointData: data.point_data
        });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    $.ajax({
      url: deleteUrl,
      type: "DELETE",
      dataType: "json",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        console.log("Success " + data);
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  handlePostDataToServer(rankUrl, e) {
    e.preventDefault();
    $.ajax({
      url: rankUrl,
      type: "POST",
      dataType: "json",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        console.log("Success " + data);
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue updating rank. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  render() {
    var _this = this;
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
            {this.state.pointData.map(function(pointData) {
              return (
                <li key={pointData.id}>
                  <div className="collapsible-header">
                    {pointData.rank+". "+pointData.title}
                    <a id={pointData.id} href={pointData.delete_url}
                       className="secondary-content" key={pointData.id}
                       onClick={_this.handleDeleteDataFromServer.bind(this, pointData.delete_url)}>
                    <i className=" blue-text material-icons">delete_forever</i>
                    </a>
                    <a id={pointData.id} href={pointData.datum_show_url}
                       className="secondary-content">
                      <i className=" blue-text material-icons">launch</i>
                    </a>
                    <a id={pointData.id} href="#"
                       onClick={_this.handlePostDataToServer.bind(this, pointData.decrease_url)}
                       className="secondary-content">
                      <i className=" blue-text material-icons">call_made</i>
                    </a>
                    <a id={pointData.id} href="#"
                       onClick={_this.handlePostDataToServer.bind(this, pointData.increase_url)}
                       className="secondary-content">
                      <i className=" blue-text material-icons">call_received</i>
                    </a>
                  </div>
                  <div className="collapsible-body">
                      <p>{pointData.description}</p>
                     <DataViewer url={pointData.url} data_id={pointData.id} />
                  </div>
                </li>
              );
            }, this)}
          </ul>
        </div>
        <NewPointDatum
          point_id={this.props.point_id}
          data_url={this.props.data_url}
          new_point_datum_url={this.props.new_point_datum_url}
          />
      </div>
    );
  }
}
SinglePoint.displayName = "SinglePoint";
SinglePoint.propTypes = {
  pollInterval: React.PropTypes.number,
  qrCode: React.PropTypes.any,
  getUrl: React.PropTypes.string.isRequired,
  new_point_datum_url: React.PropTypes.string.isRequired,
  data_url: React.PropTypes.string.isRequired,
  point_id: React.PropTypes.number.isRequired
}
