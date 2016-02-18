class GenericList extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    setInterval(this.handleLoadDataFromServer.bind(this), this.state.pollInterval);
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({ data: data });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(id) {
    console.log(id);
    $.ajax({
      url: this.props.deleteUrl + "/" +id,
      type: "POST",
      data: {"_method":"delete"},
      success: function(data){
        console.log("Success " + data);
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    return (
      <div className="collection">
        {this.state.data.map(function(item, i) {
          return (
            <div key={item.id} className="collection-item">
              <div>
                {item.data}
                <a href="" className="secondary-content" key={i}
                             onClick={_this.handleDeleteDataFromServer.bind(this, i)}>
                  <i className=" blue-text material-icons">delete_forever</i>
                </a>
              </div>
            </div>
          );
        }, this)}
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  deleteUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
};
