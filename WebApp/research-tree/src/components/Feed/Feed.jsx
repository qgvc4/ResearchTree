import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import { Layout } from 'antd';

import FeedList from './FeedList'
import PostFeed from './PostFeed';
import NavbarFeed from './Navbar';

const {
    Content, Sider, Header,
  } = Layout;

class Feed extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ? 
                    renderFeed(): 
                    <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderFeed() {
    return(
        //try layout
        <div>
            <Layout>
            <Header style={{background:'#c1e791'}}><h1 style={{color:'white'}}>ResearchTree</h1></Header>
                <Layout>
                    <Sider>
                        <NavbarFeed />
                    </Sider>
                    <Content>
                        <PostFeed />
                        <FeedList />
                    </Content>
                </Layout>
            </Layout>
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(Feed);