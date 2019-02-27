import React, { Component } from 'react'
import {Route,Link,Switch,Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

class Feed extends Component {
    render() {
        if (this.props.user.userToken == null) {
            return <Redirect to='/Login' />
        }

        return (
            <div>Feed</div>
        )
    }
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(Feed);