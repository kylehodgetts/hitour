class GenericList extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 1000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.mounted = true;
    DataUtil.handleLoadDataFromServer.bind(this,this.props.getUrl),
    this.interval = setInterval(
      DataUtil.handleLoadDataFromServer.bind(this,this.props.getUrl),
      this.state.pollInterval
    );
  }

  componentWillUnmount() {
    this.mounted = false;
    clearInterval(this.interval);
  }

  renderVerified(item) {
    if(item.activated) {
      return(
        <i title="Verified User"
           className="secondary-content green-text material-icons">
          verified_user
        </i>
      );
    }
    else {
      return(
        <i title="Unverified User"
           className="secondary-content orange-text material-icons">
          info
        </i>
      );
    }
  }
  render () {
    var _this = this;
    return (
      <div className="collection">
        {this.state.data.map(function(item, i) {
          if(item.data.length > 25 && $(document).width() <= 350){
            item.data = item.data.substring(0,25)+"...";
          }
          return (
            <div key={item.id} className="collection-item grey lighten-5">
              <div>
                {item.data}
                <a id={item.id} href="" className="secondary-content" key={i}
                             onClick={DataUtil.handleDeleteDataFromServer.bind(this, item.delete_url,"Are you sure you want to delete this record?")}>
                  <i className=" blue-text material-icons">delete_forever</i>
                </a>
                {item.show_url &&
                  <a id={item.id} href={item.show_url} className="secondary-content">
                    <i className=" blue-text material-icons">launch</i>
                  </a>
                }
                {this.props.users &&
                  this.renderVerified(item)
                }
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
  pollInterval: React.PropTypes.number,
  users: React.PropTypes.bool
};
