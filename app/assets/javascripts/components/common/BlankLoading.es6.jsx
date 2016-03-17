class BlankLoading extends React.Component{
  render () {
    return (
      <div className="container center-align" style={{marginTop:'20%'}}>
        <div className="preloader-wrapper big active">
          <div className="spinner-layer spinner-blue-only">
            <div className="circle-clipper left">
              <div className="circle"></div>
            </div>
            <div className="gap-patch">
              <div className="circle"></div>
            </div>
            <div className="circle-clipper right">
              <div className="circle"></div>
            </div>
          </div>
        </div>
        <p>Loading content...</p>
      </div>
    );
  }
}
