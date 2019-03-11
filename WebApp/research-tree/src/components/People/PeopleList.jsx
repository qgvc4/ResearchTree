import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchPosts} from '../../actions/PeopleAction'
import PeopleCard from './PeopleCard';

class PeopleList extends Component {
    componentWillMount() {
        this.props.fetchPosts(this.props.token);
    }

    render() {
        
        const PeopleItems = this.props.users.map(user => (
            <div key={user.id}>
            
                <PeopleCard title={user.firstName} description={user.lastname} date={user.standing}/>
            </div>
        ));
        return (
        <div>
            <h1>People</h1>
            {PeopleItems}
        </div>
        )
    }
}

PeopleList.propTypes = {
    fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    users: state.user.users,
    error: state.user.error
  })

export default connect(mapStateToProps, { fetchPosts })(PeopleList);