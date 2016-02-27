class SingleTour extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      tour: [],
      audience: [],
      points: [],
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
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.showUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          tour: data[0]["tour"],
          audience: data[0]["audience"],
          points: data[0]["points"]
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

  render () {
    var _this = this;
    return (
      <div>
        <div>
          {this.state.tour.name &&
            <GenericEdit value={this.state.tour.name} 
            			 postUrl={this.props.update_tour_url}
            			 attributeName="tour[name]"/> 
          }
          <h5>{this.state.audience.name}</h5>
        </div>
        <br />
        <h4>Points</h4>
        <div className="collection">
          {this.state.points.map(function(point) {
            return (
              <div key={point.id} className="collection-item">
                <div>
                  {point.name}
                  <a id={point.id} href={point.delete_url} className="secondary-content" key={point.id}
                             onClick={_this.handleDeleteDataFromServer.bind(this, point.delete_url)}>
                  <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                  <a id={point.id} href={point.show_url} className="secondary-content">
                    <i className=" blue-text material-icons">launch</i>
                  </a>
                  <a id={point.id} href="#" onClick={_this.handlePostDataToServer.bind(this, point.increase_url)}  className="secondary-content">
                    <i className=" blue-text material-icons">call_received</i>
                  </a>
                  <a id={point.id} href="#" onClick={_this.handlePostDataToServer.bind(this, point.decrease_url)} className="secondary-content">
                    <i className=" blue-text material-icons">call_made</i>
                  </a>
                </div>
              </div>
            );
          }, this)}
        </div>
        <NewTourPoint
          tour_id={this.props.tour_id}
          points_url={this.props.points_url}
          new_tour_point_url={this.props.new_tour_point_url}
          />
      </div>
    );
  }
}

SingleTour.displayName = "SingleTour";
SingleTour.propTypes = {
  new_tour_point_url: React.PropTypes.string.isRequired,
  showUrl: React.PropTypes.string.isRequired,
  update_tour_url: React.PropTypes.string.isRequired,
  points_url:React.PropTypes.string.isRequired,
  tour_id: React.PropTypes.number.isRequired,
  pollInterval: React.PropTypes.number
}
